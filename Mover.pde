Mover[] movers = new Mover[100];

void setup() {
  size(1000, 500);
  noStroke();
  for (int i = 0; i < movers.length; i++) {
    movers[i] = new Mover(random(0.1, 5), 0, 0);
  }
}

class Mover {
  PVector location;
  PVector velocity;
  PVector acceleration;

  float mass;

  Mover(float m, float x, float y) {
    mass = m;
    x=random(100, 550);
    

    location = new PVector(x, y);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
  }

  void applyForce(PVector force) {
    PVector f = PVector.div(force, mass);
    acceleration.add(f);
  }

  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
  }

  void display() {
    fill(mass*70, 0, 0);
    ellipse(location.x, location.y, mass*10, mass*10);
  }

  void checkEdges() {
    if (location.x > width) {
      location.x = width;
      velocity.x *= -1;
    } else if (location.x < 0) {
      velocity.x *= -1;
      location.x = 0;
    }
    if (location.y > height) {
      velocity.y =-1;
      location.y = height;
    }
  }
}


void draw() {
  background(0, 0, 255);
  fill(0, 0, 100);
  rect(0,0,1000,250);

  fill(#CBC850);
  ellipse(900,100,100,100);
    fill(0, 0, 100);
    ellipse(930,100,100,100);
  float c = 0.05;
  for (int i = 0; i < movers.length; i++) {


    float speed = movers[i].velocity.mag();
    PVector friction = movers[i].velocity.get();
    friction.mult(-1);
    friction.normalize();
    friction.mult(c*speed*speed);


    PVector friction2 = movers[i].velocity.get();
    friction2.mult(-1);
    friction2.normalize();
    friction2.mult(c);

    PVector wind = new PVector(0.005, 0);

    float m = movers[i].mass;
    PVector gravity = new PVector(0, 0.1*m);

    if (movers[i].location.y>250) {
      movers[i].applyForce(friction);
    }
    movers[i].applyForce(friction2);
    movers[i].applyForce(wind);
    movers[i].applyForce(gravity);
    movers[i].update();
    movers[i].display();
    movers[i].checkEdges();
  }
}
