"""
    two_sum_sorted(a, b)

*unchecked* requirement `|a| ≥ |b|`

Computes `s = fl(a+b)` and `e = err(a+b)`.
"""
@inline function two_sum_sorted(a::T, b::T) where T<:SysFloat
    s = a + b
    e = b - (s - a)
    return s, e
end

"""
    two_sum(a, b)

Computes `s = fl(a+b)` and `e = err(a+b)`.
"""
@inline function two_sum(a::T, b::T) where T<:SysFloat
    s = a + b
    v = s - a
    e = (a - (s - v)) + (b - v)
    return s, e
end


"""
    two_diff_sorted(a, b)
    
*unchecked* requirement `|a| ≥ |b|`

Computes `s = fl(a-b)` and `e = err(a-b)`.
"""
@inline function two_diff_sorted(a::T, b::T) where T<:SysFloat
    s = a - b
    e = (a - s) - b
    s, e
end

"""
    two_diff(a, b)

Computes `s = fl(a-b)` and `e = err(a-b)`.
"""
@inline function two_diff(a::T, b::T) where T<:SysFloat
    s = a - b
    v = s - a
    e = (a - (s - v)) - (b + v)

    s, e
end

"""
    two_prod(a, b)

Computes `s = fl(a*b)` and `e = err(a*b)`.
"""
@inline function two_prod(a::T, b::T) where T<:SysFloat
    p = a * b
    e = fma(a, b, -p)
    p, e
end

"""
    two_square(a)

Computes `s = fl(a*a)` and `e = err(a*a)`.
"""
@inline function two_square(a::T) where T<:SysFloat
    p = a * a
    e = fma(a, a, -p)
    p, e
end



"""
    three_sum_sorted(a, b, c)
    
*unchecked* requirement `|a| ≥ |b| ≥ |c|`

Computes `s = fl(a+b+c)` and `e1 = err(a+b+c), e2 = err(e1)`.
"""
function three_sum_sorted(a::T,b::T,c::T) where T<:SysFloat
    s, t = two_sum_sorted(b, c)
    x, u = two_sum_sorted(a, s)
    y, z = two_sum_sorted(u, t)
    x, y = two_sum_sorted(x, y)
    return x, y, z
end

"""
    three_sum(a, b, c)
    
Computes `s = fl(a+b+c)` and `e1 = err(a+b+c), e2 = err(e1)`.
"""
function three_sum(a::T,b::T,c::T) where T<: SysFloat
    s, t = two_sum(b, c)
    x, u = two_sum(a, s)
    y, z = two_sum(u, t)
    x, y = two_sum_sorted(x, y)
    return x, y, z
end

"""
    three_diff_sorted(a, b, c)
    
*unchecked* requirement `|a| ≥ |b| ≥ |c|`

Computes `s = fl(a-b-c)` and `e1 = err(a-b-c), e2 = err(e1)`.
"""
function three_diff_sorted(a::T,b::T,c::T) where T<:SysFloat
    s, t = two_diff_sorted(-b, c)
    x, u = two_sum_sorted(a, s)
    y, z = two_sum_sorted(u, t)
    x, y = two_sum_sorted(x, y)
    return x, y, z
end

"""
    three_diff(a, b, c)
    
Computes `s = fl(a-b-c)` and `e1 = err(a-b-c), e2 = err(e1)`.
"""
function three_diff(a::T,b::T,c::T) where T<: SysFloat
    s, t = two_diff(-b, c)
    x, u = two_sum(a, s)
    y, z = two_sum(u, t)
    x, y = two_sum_sorted(x, y)
    return x, y, z
end
