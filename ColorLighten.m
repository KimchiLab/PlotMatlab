function [light_color] = ColorLighten(color)

light_color = 1-(1-color).^2;
