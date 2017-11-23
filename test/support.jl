#=

   aa = ldexp(pi+0.0,10); bb = ldexp(1.0/pi,-20);
   cc = ldexp(sqrt(pi),-50)


   # to find the cannonical doubledouble form for (aa, bb) and (bb, cc)
   ab_hi, ab_lo = dd(aa, bb);  ab_dd = (ab_hi, ab_lo)
   bc_hi, bc_lo = dd(bb, cc);  bc_dd = (bc_hi, bc_lo)
   
   # to find the cannonical doubledouble result of ab_dd^0.125
   fn = (x)->x^0.125
   fn_dd( fn, ab_dd... )
   # (2.7442977444860794, 1.6017759624720273e-16)

   

   # to find the cannonical tripledouble form for (aa, bb, cc)
   x, y, z = ddd(aa, bb, cc)
   tripdoub = (x, y, z) 

   # to find the cannonical tripledouble result of sqrt( tripdoub )

   fn_ddd( o->sqrt(o), tripdoub...)
   (56.71852323165257, -4.670650518938076e-17, 1.868095270344935e-33)


=#

setprecision(BigFloat, 1500)

# sum of hi, .., lo as BigFloats
bigflt(xs...) = sum(map(BigFloat,xs))


function big2double(::Type{T}, b) where T
   hi = T(b)
   return hi
end
big2double(b) = big2double(Float64, b)

function big2doubledouble(::Type{T}, b) where T
   hi = T(b)
   bf = b - BigFloat(hi)
   lo = T(bf)
   return hi, lo
end
big2doubledouble(b) = big2doubledouble(Float64, b)

function big2tripledouble(::Type{T}, b) where T
   hi = T(b)
   bf = b - BigFloat(hi)
   md = T(bf)
   bf = b - BigFloat(hi) - BigFloat(md)
   lo = T(bf)
   return hi, md, lo
end
big2tripledouble(b) = big2tripledouble(Float64, b)

function big2quaddouble(::Type{T}, b) where T
   hi = T(b)
   bf = b - BigFloat(hi)
   mhi = T(bf)
   bf = b - BigFloat(hi) - BigFloat(mhi)
   mlo = T(bf)
   bf = b - BigFloat(hi) - BigFloat(mhi) - BigFloat(mlo)
   lo = T(bf)
   return hi, mhi, mlo, lo
end
big2quaddouble(b) = big2quaddouble(Float64, b)


function d(::Type{T}, x) where T
   bf = bigflt(x)
   return big2double(bf)
end
d(x) = d(Float64, x)

function dd(::Type{T}, x, y=zero(T)) where T
   bf = bigflt(x, y)
   return big2doubledouble(bf)
end
dd(x, y) = dd(Float64, x, y)

function ddd(::Type{T}, x, y=zero(T), z=zero(T)) where T
   bf = bigflt(x, y, z)
   return big2tripledouble(bf)
end
ddd(x, y, z) = ddd(Float64, x, y, z)

function dddd(::Type{T}, w, x=zero(T), y=zero(T), z=zero(T)) where T
   bf = bigflt(w, x, y, z)
   return big2quaddouble(bf)
end
dddd(w, x, y, z) = dddd(Float64, w, x, y, z)

function fn1arg_d(::Type{T}, fn, x) where T
   a = d(T, x)
   b = bigflt(a)
   result = fn(b)   
   return big2double(result)
end
fn1arg_d(fn, x) = fn1arg_d(Float64, fn, x)

function fn2arg_d(::Type{T}, fn, x, y=zero(T)) where T
   bx, by = bigflt(x), bigflt(y)
   result = fn(bx, by)   
   return big2doubledouble(result)
end
fn2arg_d(fn, x, y) = fn1arg_d(Float64, fn, x, y)


function fn1arg_dd(::Type{T}, fn, hi, lo=zero(T)) where T
   hi, lo = dd(T, hi, lo)
   b = bigflt(hi, lo)
   result = fn(b)   
   return big2doubledouble(result)
end
fn1arg_dd(fn, hi, lo) = fn1arg_dd(Float64, fn, hi, lo)

function fn2arg_dd(::Type{T}, fn, xhi, xlo=zero(T), yhi=zero(T), ylo=zero(T)) where T
   xhi, xlo = dd(xhi, xlo)
   yhi, ylo = dd(yhi, ylo)
   bx = bigfloat(xhi, xlo)
   by = bigfloat(yhi, ylo)
   result = fn(bx, by)
   return big2doubledouble(result)
end
fn2arg_dd(fn, xhi, xlo, yhi, ylo) = fn2arg_dd(Float64, fn, xhi, xlo, yhi, ylo)


function fn_ddd(::Type{T}, fn, x, y=zero(T), z=zero(T)) where T
   ahi, amd, alo = ddd(x,y,z)
   b = bigflt(ahi, amd, alo)
   result = fn(b)   
   return big2tripledouble(result)
end
fn_ddd(fn, x, y, z) = fn_ddd(Float64, fn, x, y, z)

function fn_dddd(::Type{T}, fn, w, x=zero(T), y=zero(T), z=zero(T)) where T
   ahi, amhi, amlo, alo = dddd(w,x,y,z)
   b = bigflt(ahi, amhi, amlo, alo)
   result = fn(b)   
   return big2quaddouble(result)
end
fn_dddd(fn, w, x, y, z) = fn_dddd(Float64, fn, w, x, y, z)
