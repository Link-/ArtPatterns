/**
 * For so long I've been fascinated by Islamic Art patterns
 * and their geometrical complexity, not to mention the complexity
 * attached to replicating and animating them.
 *
 * This project is a naive attempt at replicating some Art patterns 
 * and animating them in interesting ways.
 *
 * This is a work in progress.
 * 
 * @author: 	Bassem Dghaidy
 * @website: 	http://bassemdy.com
 * @version:	0.02
 * @license:	...
 */

/**
 * The entierty of the code is not commented
 * but it will be done later.
 */

// ArrayList containing TriangloPods 
// for the animation
ArrayList trList;

int incP = 0;

float time       = 0.0;
float time2      = 0.0;
float increment  = 0.008;
float increment2 = 0.009;

void setup()
{
	// Initial Configuration
	size(1024, 768);
	background(203);
	smooth();

	// Set the framerate to smooth
	// the animation
	frameRate(25);

	// Create the initial TriangloPod list
	trList = new ArrayList();
	for (int i = 0; i < 10; i++)
	{
		trList.add(new TriangloPod(width/2, height/2, i*5, 0.5, 0.4));
	}
}

void draw() 
{
	// Always reset the background
	// to clear out previous frames
	background(203);

	// Reset the stroke color / weight and fill color
	stroke(255);
	strokeWeight(1);
	noFill();

	float n  = noise(time);
	float na = noise(time2);
	
	// With each cycle, increment the " time "
	time     += increment;
	time2    += increment2;


	// Update each element of the Trianglopods list
	for (int i = 0; i < trList.size(); i++)
	{
		TriangloPod xP = (TriangloPod) trList.get(i);
		xP.update(1.2*i/10, 1, pow(na*10, 3));
		xP.incPoints(incP);
	}
}

void mouseClicked()
{
	incP++;
	println(incP);
}

/**
 * TriangloPod Class
 * 
 */

class TriangloPod
{
	int x, y;									// Coordinates
	float outerRadius = min(width, height);		// Outer Radius Value
	float innerRadius = outerRadius;			// Inner Radius Value
	float pts         = 1;						// Number of points for the shape
	float angle       = 0;						// Angle of rotation
	float rot 		  = 180.0/pts;				// Incremental rotation for each shape

	// Constructor
	TriangloPod(int posX, int posY, float angPos, float outR, float innerR)
	{
		x           = posX;
		y           = posY;
		angle       = angPos;
		outerRadius = outerRadius * outR;
		innerRadius = outerRadius * innerR;
	}

	void incPoints(int value)
	{
		if (value > pts)
			pts += value;
		println(pts);
	}

	/**
	 * Update method
	 *
	 * @param: float
	 * @return: null
	 */
	void update(float ang)
	{
		if (ang > 0.0)
			angle += ang;

		beginShape(TRIANGLE_STRIP);
		for (int i = 0; i <= pts; i++)
		{
			float px = x + cos(radians(angle)) * outerRadius;
			float py = y + sin(radians(angle)) * outerRadius;

			angle    += rot;
			
			vertex(px, py);

			px       = x + cos(radians(angle)) * innerRadius;
			py       = y + sin(radians(angle)) * innerRadius;
			
			vertex(px, py); 
			
			angle    += rot;
		}
	 	endShape();
	}

	/**
	 * Overload update method
	 *
	 * @param: float, float, float
	 * @return: null
	 */
	void update(float ang, float outR, float innerR)
	{
		if (ang > 0.0)
			angle += ang;

		outR   = outerRadius * outR;
		innerR = innerR;

		beginShape(TRIANGLE_STRIP);
		for (int i = 0; i <= pts; i++)
		{
			float px = x + cos(radians(angle)) * outR;
			float py = y + sin(radians(angle)) * outR;

			angle    += rot;
			
			vertex(px, py);

			px       = x + cos(radians(angle)) * innerR;
			py       = y + sin(radians(angle)) * innerR;
			
			vertex(px, py); 
			
			angle    += rot;
		}
	 	endShape();
	}
}