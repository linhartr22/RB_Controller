RB_Controller V1.0
2014-02-24 Roger Linhart

This is a Processing 2.1 script to use a webcam to process the Rock Band game display and play an instrument.

The script has code to display the video mode your camera supports which is commented out once the video mode is decided.

The script displays an overlay on the webcam video. A white box denotes the area the script will monitor for fret button presses and strums. Under each white box is a color fret button indicator. Each frame, the script computes an average color for each white box and fills the box with that color.

To Do:
Capture video of Rock Band game display to determine black/background color. Compare the background color to the average color to determine if the corresponding fret button should be pressed. Don't know why I drew this by modifying pixels instead of rect(). Going to have to fix that!

Add strum function and indicator.

If you found this fun or interesting please make a small donation to my PayPal account at https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=GTBD7T7BXPGQY. I have many more Arduino projects in mind and appreciate your support.