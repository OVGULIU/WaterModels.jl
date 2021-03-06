###############################################################################
# This file defines the nonlinear head loss functions for water systems models.
###############################################################################

function if_alpha(alpha::Float64)
    return function(x::Float64)
        return inv(2.0 + alpha) * (x*x)^(1.0 + 0.5*alpha)
    end
end

function f_alpha(alpha::Float64)
    return function(x::Float64)
        return sign(x) * (x*x)^(0.5 + 0.5*alpha)
    end
end

function df_alpha(alpha::Float64)
    return function(x::Float64)
        return (1.0 + alpha) * (x*x)^(0.5*alpha)
    end
end

function d2f_alpha(alpha::Float64)
    return function(x::Float64)
        return x != 0.0 ? sign(x) * alpha * (1.0 + alpha) * (x*x)^(0.5*alpha - 0.5) : 0.0
    end
end

function function_if_alpha(wm::GenericWaterModel, n::Int=wm.cnw)
    alpha = wm.ref[:nw][n][:options]["headloss"] == "h-w" ? 0.852 : 1.0
    f = JuMP.register(wm.model, :if_alpha, 1, if_alpha(alpha), f_alpha(alpha), df_alpha(alpha))
    wm.fun[:nw][n][:if_alpha] = (:if_alpha, 1, if_alpha(alpha), f_alpha(alpha), df_alpha(alpha))
end

function function_f_alpha(wm::GenericWaterModel, n::Int=wm.cnw)
    alpha = wm.ref[:nw][n][:options]["headloss"] == "h-w" ? 0.852 : 1.0
    f = JuMP.register(wm.model, :f_alpha, 1, f_alpha(alpha), df_alpha(alpha), d2f_alpha(alpha))
    wm.fun[:nw][n][:f_alpha] = (:f_alpha, 1, f_alpha(alpha), df_alpha(alpha), d2f_alpha(alpha))
end

function function_f_alpha_args(wm::GenericWaterModel, n::Int=wm.cnw)
    alpha = wm.ref[:nw][n][:options]["headloss"] == "h-w" ? 0.852 : 1.0
    return :f_alpha, 1, f_alpha(alpha), df_alpha(alpha), d2f_alpha(alpha)
end
