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
 * @version:	0.01
 * @license:	...
 */

/**
 * The entierty of the code is not commented
 * but it will be done later.
 */

ArrayList trList;

void setup()
{
	size(1024, 768);
	background(203);
	smooth();

	frameRate(25);

	trList = new ArrayList();
	for (int i = 0; i < 10; i++)
	{
		trList.add(new triangularium(width/2, height/2, i*5));
	}
}

void draw() 
{
	background(203);
	stroke(0);
	strokeWeight(1);
	noFill();

	for (int i = 0; i < trList.size(); i++)
	{
		triangularium xP = (triangularium) trList.get(i);
		xP.update(1.8*i/10);
	}
}

void mouseClicked() 
{
	trList.add(new triangularium(width/2, height/2, random(1, trList.size())));
}

class triangularium
{
	int x, y;
	float outerRadius = min(width, height) * 0.2;
	float innerRadius = outerRadius * 0.1;
	float pts         = 5;
	float angle       = 0;
	float rot 		  = 180.0/pts;

	triangularium(int posX, int posY, float angPos)
	{
		x     = posX;
		y     = posY;
		angle = angPos;
	}

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
}