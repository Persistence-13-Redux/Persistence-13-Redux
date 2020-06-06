//Interface for using DrawBox() to draw 1 pixel on a coordinate.
//Returns the same icon specifed in the argument, but with the pixel drawn
/proc/DrawPixel(icon/I,colour,drawX,drawY)
	if(!I)
		return 0

	var/Iwidth = I.Width()
	var/Iheight = I.Height()

	if(drawX > Iwidth || drawX <= 0)
		return 0
	if(drawY > Iheight || drawY <= 0)
		return 0

	I.DrawBox(colour,drawX, drawY)
	return I


//Interface for easy drawing of one pixel on an atom.
/atom/proc/DrawPixelOn(colour, drawX, drawY)
	var/icon/I = new(icon)
	var/icon/J = DrawPixel(I, colour, drawX, drawY)
	if(J) //Only set the icon if it succeeded, the icon without the pixel is 1000x better than a black square.
		icon = J
		return J
	return 0