local GeometricUtils = {}

function GeometricUtils:pointInBox(P,A,B)--Point P inside box A,B
   return P.x >= math.min(A.x,B.x) and P.x <= math.max(A.x,B.x) and
   P.y >= math.min(A.y,B.y) and P.y <= math.max(A.y,B.y)
end

function GeometricUtils:perpendicularPoint(A,B,P)
   local  D = P:add(B:sub(A):orto())--perpendicular to AB

   local K1 = Vector:cross(P:sub(A), D:sub(P))
   local K2 = Vector:cross(B:sub(A), D:sub(P))
   return A:add(B:sub(A):mul(K1/K2))
end

function GeometricUtils:distToSegment(A,B,P)
   local p_int = GeometricUtils:perpendicularPoint(A,B,P)
   if GeometricUtils:pointInBox(p_int,A,B) then
      return P:dist(p_int),p_int
   else --The answer is some Point
      local da = A:dist(P)
      local db = B:dist(P)
      if da < db then p_int = A else p_int = B end
      return math.min(da,db),p_int
   end
end

function GeometricUtils:getSegmentInsideCircle(vA,vB,vC,R)
   local P = GeometricUtils:perpendicularPoint(vA,vB,vC)
   local dist = P:dist(vC)
   if dist <= R then
      local h = P:dist(vC)
      local b = (R*R - h*h)^0.5

      local dir = vC:sub(P):orto()
      if h == 0 then dir = vC:sub(vA) end

      local vIA = P:add(dir:unit():mul(b))
      local vIB = P:add(dir:unit():mul(-b))

      if GeometricUtils:pointInBox(vIA,vA,vB) == false then
         if vIA:dist(vA) < vIA:dist(vB) then vIA = vA else vIA = vB end
      end
      if GeometricUtils:pointInBox(vIB,vA,vB) == false then
         if vIB:dist(vA) < vIB:dist(vB) then vIB = vA else vIB = vB end
      end

      --local pmid = display.newCircle(P.x,P.y,5)
      --local pIA = display.newCircle(vIA.x,vIA.y,5)
      --local pIB = display.newCircle(vIB.x,vIB.y,5)

      return vIA,vIB
   end
   return nil,nil
end

function GeometricUtils:pointOverSegment(P,A,B)--P over AB
   return math.abs(Vector:area2(A,B,P)) <= 0 and GeometricUtils:pointInBox(P,A,B)
end

function GeometricUtils:segmentsIntersect(A,B,C,D)
   -- print (A, B, C, D)
   local A1 = Vector:area2(C,D,A)
   local A2 = Vector:area2(C,D,B)
   local A3 = Vector:area2(A,B,C)
   local A4 = Vector:area2(A,B,D)

   if( ((A1 > 0 and A2 < 0) or (A1 < 0 and A2 > 0)) and
         ((A3 > 0 and A4 < 0) or (A3 < 0 and A4 > 0))) then
      return true

   elseif A1 == 0 and GeometricUtils:pointOverSegment(A, C, D) then return true;
   elseif A2 == 0 and GeometricUtils:pointOverSegment(B, C, D) then return true;
   elseif A3 == 0 and GeometricUtils:pointOverSegment(C, A, B) then return true;
   elseif A4 == 0 and GeometricUtils:pointOverSegment(D, A, B) then return true;
   else return false
   end
end

function GeometricUtils:pointInsidePolygon(p,poly)
   local cont = 0
   local act,sig

   for i=1,#poly-1 do
      if GeometricUtils:pointOverSegment(p,poly[i],poly[i+1]) then
         return true
      end

      act = poly[i]:sub(p);
      sig = poly[i+1]:sub(p);
      if  act.y > sig.y then act,sig = sig,act end
      if act.y < 0 and sig.y >= 0 and Vector:cross(sig,act) >= 0 then cont = cont + 1 end
   end

   return cont % 2 == 1
end

--Polygon A inside Polygon B
function GeometricUtils:polygonInsidePolygon(polyA,polyB)
   for j=1,#polyA-1 do
      if GeometricUtils:pointInsidePolygon(polyA[j],polyB) then
         return true
      end
   end

   return false
end

--The last point of a poly is the same as the last one
function GeometricUtils:polygonsIntersect(polyA,polyB)
   for i=1,#polyA-1 do
      local a1,a2 = polyA[i],polyA[i+1]
      for j=1,#polyB-1 do
         local b1,b2 = polyB[j],polyB[j+1]

         if GeometricUtils:segmentsIntersect(a1,a2,b1,b2) then
            return true
         end
      end
   end
   return false
end

function GeometricUtils:collideCircleRect(center,radius,rectPolygon)
   if GeometricUtils:distToSegment(rectPolygon[1],rectPolygon[2],center) <= radius then return true end
   if GeometricUtils:distToSegment(rectPolygon[2],rectPolygon[3],center) <= radius then return true end
   if GeometricUtils:distToSegment(rectPolygon[3],rectPolygon[4],center) <= radius then return true end
   if GeometricUtils:distToSegment(rectPolygon[4],rectPolygon[5],center) <= radius then return true end

   return false
end

function GeometricUtils:horizontalSegmentsCollide(x1,x2,xx1,xx2)
   return (x1 >= xx1 and x1 <= xx2) or (x2 >= xx1 and x2 <= xx2) or (xx1 >= x1 and xx1 <= x2) or (xx2 >= x1 and xx2 <= x2)
end

function GeometricUtils:collideCircleRect2(center,ax,ay,bx,by)
   if center.x >= ax and center.x <= bx and center.y >= ay and center.y <= by then
      return true
   end

   return false
end

return GeometricUtils
