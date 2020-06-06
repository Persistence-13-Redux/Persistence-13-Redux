/proc/imgcode2html(t, var/image/img1, var/image/img2, var/mob/user)
	if(img1)
		user << browse_rsc(img1.icon, "tmp_img1.png")
		t = replacetext(t, "\[IMG1\]", "<img src='tmp_img1.png' width='192' style='-ms-interpolation-mode:nearest-neighbor' />")
	if(img2)
		user << browse_rsc(img2.icon, "tmp_img2.png")
		t = replacetext(t, "\[IMG2\]", "<img src='tmp_img2.png' width='192' style='-ms-interpolation-mode:nearest-neighbor' /> ")
	return t
