Memory Dream Rail

Memory Dream Rail is a photo/image displaying shader, showing images on frame rail. It&#39;s a geometry shader, which means it takes existing mesh triangles to create the photo rail. It allows to efficiently display large numbers of photos (there theoretically no limit, 16 spreadsheets as much as can fit in specific resolution), using single draw call per single rail (but take more VRAM in exchange as all photos need to be in memory). Shader features a lot of fading effects, as well supports flipbook animation and stereoscopic images (3D Images). Because it is a shader, it also allows to put entire galleries in a single avatar as well with proper scripting be used in UI systems.

# **1. Image Preparation**

**1.1 Preparing Spreadsheets**

All images that are used in this folder need to have the same ratio and packed into a spreadsheet grid, the shader will display images starting from left to right, starting from row above to bottom. Also all spreadsheets should have the same grid size.

You prepare a spreadsheet with any image editor, but there are tools that allow you to do this quicker. ImageMagick which you can download here and follow the instruction, make sure magick command is accessible in you system command line:

[https://imagemagick.org/script/download.php#windows](https://imagemagick.org/script/download.php#windows)

Now throw all images into a single folder, grid will be sorted by name so rename if you desire specific older. If the names of images have a date they should be sorted by oldest to newest. We assume all images are jpgs. Now using command line execute this command:

magick montage \*.jpg -tile COLSxROWS -geometry XXXXxYYYY+0+0 -quality 85 spreedsheet.jpg

Replace those with:

COLS - Number of columns in spreadsheet

ROWS - Number of rows in spreadsheet

XXXX - Width of single image

YYYY - Height of single image

This should create multiple spreadsheets with all photos in the folder. You can change \*.jpg to make magick pic different photos. In shader zip you should find example spreadsheets to play around with.

**1.2 Flipbook images**

Shader can animate flip book spreadsheet, you pick a number of frames per animation and shader will flip thru frames in the spreadsheet until the next flip book sequence begins. You just need to order images correctly. Due to limitations each sequence needs to consist of the same amount of frames. Best way to make images is by photo shatter with a camera in VRChat, pick for example 4 of each sequence, put them in a single folder, date on photos should order them correctly. Then just follow the same steps as above.

**1.3 Stereoscopic images**

Stereoscopic images allow us to display 3D images. Stereo images are images that consist of images for the right and left eye separately. In VR, the shader will display each on different eyes and rest is done by your brain. Fascinating isn&#39;t it? In fact, by the same technique you have a sense of depth in VR as each eye gets, a different image from different points in space, same as in real life.

Stereo images need to be to be taken from point of eyes, one camera need to be shifted left and other to the right from center point, the created image should have 2 images for each eye camera side by side (without any gaps)

There is no way to create stereo images direcly in VRChat, but theoretically possible by a solution similar to VirtualLens or VRCLens. However, SteamVR does take stereo image, if you take a screenshot in VR in SteamVR (not only in VRChat) it will take stereo screenshot and save both single image and image from both eyes. You need to go to the steam screenshot directory to retrieve those, they should end with \_vr.jpg.

You can also find examples of stereo images on the internet, shader supports both horizontal and vertical stereo image configuration as inversion of eye images, so it should support any stereo image, except scanline or analog (red-blue glasses) configurations.

Desktop users will fallback to left eye image, or right eye if you choose an option to do so and will see 2D image.

Some people may feel discomfort viewing stereo images in VR, it should not be as strong as motion sickness, but from my experience some people have negative responses to them. That&#39;s why I recommend adding the option to disable stereo (&quot;Hide Stereo&quot; parameter). Shader also features stereo fader, allowing you to see the image in stereo only at a specific angle and distance, it&#39;s turned on by default.

# **2. Setting up game object**

To use a shader you need to have a static mesh that have enough triangles to display all the frames ( 5 frames visible will require 10 triangles on the mesh). If you are not sure just a palace Sphere object, it should have enough.

Because this shader deforms the original mesh bounding box may not match the rail, scale original mesh enough that it fits the entire rail, if you don&#39;t do that rail will disappear when the bounding exits the camera view.

For that reason game object scale don&#39;t scale rail itself, to scale the rail scale size of images. You can also disable this behavior if you wish, but will make tuning of the bounding box more difficult.

Now make new material, use it on your mesh game object and set the shader to &quot;Memory Dream Rail&quot; and put your spreadsheet to spreadsheet texture slots. Input in parameters how many spreadsheets there are, how many rows and columns as well as image ratio and thats it, set Auto Progression to make it move on by itself. Now you can play around with parameters.

# **3. Parameters**

Here list of all parameters and descriptions of all features.

**3.1 Progression**

Rail let you manually control progression as well as automatic on any speed.

**Progress** - Parameter that progresses the rail manually, 1 digit is 1 photo frame, so settings to 32 will move rail to 32. You can use this animate rail on your own or move rail via scripting.

**Auto Progression Speed** - This parameter makes the rail move on it&#39;s own, photo frames/s. Value can be negative, to make the rail move in the opposite direction. Note that this animation is powered by a shader timer, it&#39;s local and position (in case of VRChat) depends on the player joining the world.

**Scale Progression by Total** - If checked, above parameters progress rail by factor of all images, not just single image.

**3.2 Rail Settings**

Settings that sets dimensional appearance of rail

**Rail Radius -** Radius of the rail, how long is it, the longer the rail the more photos it can display at once and more triangles on source hosting mesh it will require.

**Frame Separation** - Distance between photo frames, the higher the number the more space between images, the less photos rail can display at once on specific radius.

**Rail Pitch/Roll** - Sets vertical rotation of rail with frames always facing forward.

**Rail Yaw** - Sets horizontal rotation of rail with frames always facing forward

**Ignore Scale** - Enabled by default, if on it will make shader ignore scale of host mesh, allowing more flexibility of tuning bounding box

**Translate** - Local position of the rail, this allows to move rial around bounding box if needed, also can be used in animation.

**3.3 Distance Faders**

This set of parameters set visibility based on distance from the viewer. Units used in most parameters here are in distance.

**Distance Fade Range** - Distance from viewer from which rail will completely disappear. Setting it to 0 will disable distance fading all together

**Distance Fade Length -** Length of a distance that rail will fade, the bigger the number the slower rail will fade based on distance.

**Fade Rail Radius** - If checked, instead of opacity fading, distance fader will reduce radius of rail until it completely disappears. Together with edge faders, this allows to create more complex distance fading effects.

**Distance Color Fade Range** - Distance from which images will fade to solid color, hiding constance of images, also let you create more complex fading effects. If set to 0 it&#39;s disabled.

**Distance Color Fade Length** - Length of distance where images slowly fade to solid color.

**Distance Color Fade FOV** - Angle form viewer which images fades to solid color, hiding its content and forcing viewer to look at images straight.

**Distance Color Fade FOV Width** - Angle width from which images slowly fades to solid color.

**3.3 Up Vector Faders**

This special fader allows to hide rail if the up vector of the host game object is not pointing up. For example, by attaching a rail to the hand of an avatar, the hand would need to face upward for the rail to become visible. This feature was specially made for avatars use in mind.

**Up Vector Fade Angle -** Angle from upward direction from which rail fades.

**Up Vector Fade Width** - width of angle from upward direction from which rail slowly fades.

**Fade Rail Radius** - If checked, instead of opacity fading, up vector fader will reduce radius of rail until it completely disappears. Together with edge faders, this allows to create more complex fading effects.

**3.4 Rail Edge Fader**

This set of parameter set fading effects of individual frames fading away on edges of the rail, affecting the appearance of rail itself. There are an entire set of different effects and you can mix them together to create even cooler effects. Each effect have common parameter so to avoid repeating same things, here the list:

**(Name of the effect)** - Parameter on the name of effect is a length of fade effect on the edges, the smaller the number the faster the frame will disappear. 0 disables the effect.

**Fade Offset** - Offset from edge of rail where effect occurs, allowing more flexible mixing of effect.

**Ease Factor** - Adding ease in to the effect, making fade more impulsive.

**Target Value** - Value to which effect targets to reach, if effect is deterministic, sor example in Scale X value 2 will scale up image twice on X axis.

**Mirror** - If effect is directional, like rotation, if checked in effect will move the frame to the opposite direction, mirroring the opposite edge.

Here list of effect and extra parameters they have

**Opacity -** Generic opacity fade

**Color Fade** - Interpolates image content to solid color

_Color_ - Color of color fade

_Multiply_ - Instead of interpolating, color fade will multiply bland to the target color

**Scale X** - Scales frame on X-axis

**Scale Y** - Scales frame on Y-axis

**Pitch rotation** - Horizontally rotates the frame to target pitch

**Yaw rotation** - Vertically rotates the frame to target yaw

**Roll rotation** - Rolls the frame to target roll rotation

**Displace** - Moves frame in space to target position offset, this effect have mirror parameter for each XYZ axis

I may add more effect in future updates.

**3.5 Image Dimensions**

Those parameters set dimensions of frames.

**Ratio X, Ratio Y** - Sets ratio of the frame, it should match the ratio of images you want to display but don&#39;t need to. If you don&#39;t know the ratio you can type in size of the image as size is the ratio value too.

**Frame Size** - Scales the frame size, too big value may cause frames to overlap.

**Frame UV Crop** - Due to texture filtering and other factors, images from spreadsheet can leak on edges, if thats the case use this parameter to crop out the edges. It&#39;s in UV factor, so 1 will crop out the entire image. X - Left Y - Right Z - Bottom W- Top

**3.6 Spreadsheet Setup**

Here you need to input the specification of spreadsheets you&#39;re gonna use, how many of them there are , how many rows and columns they have, if you input these incorrectly images will be displayed incorrectly. There also **Discard Last Frames** parameter setting how many images should be discarded from the end of the last spreadsheet, in case you got an incomplete spreadsheet at the end. If you use stereo, note that a single pair of stereo image count as one single image!

**3.7 Stereo Imagery**

Parameter related to stereoscopic images

**Stereoscopic Image** - If checked, shader assumes that the spreadsheet contains stereo images and will treat the pair of images as a single image. This should be only enabled if you really got stereo images in spreadsheet, otherwise images will be cropped by half.

**Distance Fade** - Distance from which viewer need to be to see image in stereo

**Distance Fade Length** - Length from which will slowly fallback to 2D. Too high a number may cause discomfort during fading, too small may cause shock sensation in the eyes.

**Angle Fade** - Angle window from which stereo image will be visible, viewing stereo image from high enable may cause discomfort for some people.

**Angle Fade Range** - Width of viewing angle from which image will slowly fall back to 2D image. Too high a number may cause discomfort during fading, too small may cause shock sensation in the eyes.

**Hide Stereo** - Fall backs image to 2D but still reads images as stereo (only one eye image will be displayed), this parameter allows to implement disabling of stereography.

**Fallback to Right Eye Image** - If checked, image will fallback to 2D on right eye image instead of left eye image

**Vertical Orientation** - Check this if stere images are orientated vertically (on top of eachother)

**Invert Eyes** - Swaps eye images if thats how you images are configured

Missettings of last 2 parameters surly will cause discomfort to viewers

**3.8 Flipbook Animation**

Parameters controlling flipbook animation.

**Animated Frames** - Number of images that frame will flipbook thru in single sequence

**Animation Speed** - Speed of animation (FPS)

Same as auto progression, animation is controlled by a shader timer, which is local and dependent on join time in VRChat.

**3.9 Spreadsheet Textures**

Here place all spreetsheetshaders from top to bottom. 16 is the limitation of the maximum number of samplers Unity on how many textures can be binded to the shader.

# **4.Extra Notes**

I didn&#39;t have time to fully test this shader, so there might be unexpected bugs. Raport bugs on github page:

https://github.com/Shadowriver/MemoryDreamRail

I plan to use this shader in some projects in future, so there might be updates to it.

If you used shader, i would really love see your application of it ^^ send me info on twitter @ShadowriverVR