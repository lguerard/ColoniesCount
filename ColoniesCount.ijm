macro "ColoniesCount"
{
	/* Count the number of colonies in the region drawn by the user.
	 * Made by Laurent Guerard CCI 18/10/16
	*/
	
	subtBack = true;
	goOn = true;
	//As long as you want to continue, you can.
	while(goOn)
	{
		//If we need to subtract the background or if it has already been done
		if(subtBack)
		{
			//You might want to check with other values but this one seemed alright
			run("Subtract Background...", "rolling=10 light");
			subtBack = false;
		}
		//We wait for the user to draw a selection corresponding to the agar plate
		setTool("oval");
		waitForUser("Make selection of the agar plate then click OK");
		getSelectionBounds(x,y,width,height);
		run("Duplicate...", " ");
		setAutoThreshold("IsoData");
		//run("Threshold...");
		//setThreshold(0, 240);
		//Threshold of the image
		setOption("BlackBackground", true);
		run("Convert to Mask");
		//Restore the selection made
		run("Restore Selection");
		//Reset the number of objects found in the ROI manager
		roiManager("reset");
		//Count the number of objects in the region drawn
		//You might want to change that line to remove too small objects or too big ones
		run("Analyze Particles...", "clear include add");
		coloniesCount = roiManager("count");
		//Print the result in the log window
		print("In the agar plate around "+x+" and "+y+", there are "+coloniesCount+" colonies");

		//Ask if the user wants to continue or not
		showMessageWithCancel("Click OK to check another plate on the same image or cancel to finish or change image");
	}
}