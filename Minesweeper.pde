import de.bezier.guido.*;
public final static int NUM_ROWS = 10;
public final static int NUM_COLS = 10; // all caps syntax
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines; //ArrayList of just the minesweeper buttons that are mined
public int nummines = 28;
void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to declare and initialize buttons goes here
    mines = new ArrayList <MSButton> ();
    buttons = new MSButton [NUM_ROWS][NUM_COLS];

    for ( int rows= 0; rows < NUM_ROWS; rows++){
        for( int col = 0; col < NUM_COLS; col++){
            buttons[rows][col] = new MSButton(rows,col);
        }
    }
    setmines();
}

public void setmines()
{
    for(int i = 0; i< nummines / 2; i++){
         int ranR = (int)(Math.random() * NUM_ROWS);
         int ranC = (int)(Math.random()* NUM_COLS);
        
        if(!mines.contains(buttons[ranR][ranC]))
        {
            //System.out.println(ranR+", " + ranC);
            mines.add(buttons[ranR][ranC]);
        }
    }
}

public void draw ()
{
    background( 0 );
    if(isWon()){displayWinningMessage();}
}

public boolean isWon()
{
    //your code here
    for (int r =0; r< NUM_ROWS; r++){
        for(int c=0; c< NUM_COLS; c++){
            if(buttons[r][c].isClicked() == false){
                return false;
            }
        }
    }
    return true;
   
}
public void displayLosingMessage()
{
    //your code here
    for (int r =0; r< NUM_ROWS; r++){
        for(int c=0; c< NUM_COLS; c++){
             if( buttons[r][c].isClicked() == true && mines.contains(this) ) 
                    buttons[NUM_ROWS/2][(NUM_COLS/2)-6].setLabel("L U");
                    buttons[NUM_ROWS/2][(NUM_COLS/2)-4].setLabel("SADGE");
                    buttons[NUM_ROWS/2][(NUM_COLS/2)-2].setLabel("SKILL");
                    buttons[NUM_ROWS/2][(NUM_COLS/2)].setLabel("ISSUE");
                    buttons[NUM_ROWS/2][(NUM_COLS/2)+2].setLabel("REKT");
            }
        }
}

public void displayWinningMessage()
{     
             if( isWon() == true ) 
                buttons[NUM_ROWS/2][(NUM_COLS/2)-2].setLabel("YOU");
                buttons[NUM_ROWS/2][(NUM_COLS/2)].setLabel("WIN!");
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
         width = 400/NUM_COLS;
         height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    
    public void mousePressed () 
    {
        clicked = true;
        //your code here
        if (keyPressed == true|| mousePressed && (mouseButton == RIGHT))
         {
        
          if (marked == false)
          {
            marked = true;
            clicked = true;
          }
          else if(marked == true)
          {
            clicked = false;
            marked = false;
          }
        }
        else if ( mines.contains(this))
        {
           displayLosingMessage();
        }
        else if (countmines(r,c) > 0)
        {
            setLabel(""+ countmines(r,c));
        }
        else
        {
            if(isValid(r,c-1) && !buttons[r][c-1].isClicked())
                buttons[r][c-1].mousePressed();
            if(isValid(r,c+1) && !buttons[r][c+1].isClicked())
                buttons[r][c+1].mousePressed();
            if(isValid(r-1,c) && !buttons[r-1][c].isClicked())
                buttons[r-1][c].mousePressed();
            if(isValid(r+1,c) && !buttons[r+1][c].isClicked())
                buttons[r+1][c].mousePressed();
            if(isValid(r+1,c-1) && !buttons[r+1][c-1].isClicked())
                buttons[r+1][c-1].mousePressed();
            if(isValid(r+1,c+1) && !buttons[r+1][c+1].isClicked())
                buttons[r+1][c+1].mousePressed();
            if(isValid(r-1,c+1) && !buttons[r-1][c+1].isClicked())
                buttons[r-1][c+1].mousePressed();
            if(isValid(r-1,c-1) && !buttons[r-1][c-1].isClicked())
                buttons[r-1][c-1].mousePressed();
        } 
    }

    public void draw () 
    { 

        if (marked)
            fill(0);
        else if( clicked && mines.contains(this) ) 
          fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
       if( 0 <=r && r < NUM_ROWS && 0<= c && c < NUM_COLS){
        return true;
       }
       else{
        return false;
       }
       
    }
    public int countmines(int row, int col)
    {
        int nummines = 0;
        if (isValid(row-1,col) == true && mines.contains(buttons[row-1][col]))
        {
            nummines++;
        }
        if (isValid(row+1,col) == true && mines.contains(buttons[row+1][col]))
        {
            nummines++;
        }
         if (isValid(row,col-1) == true && mines.contains(buttons[row][col-1]))
        {
            nummines++;
        }
         if (isValid(row,col+1) == true && mines.contains(buttons[row][col+1]))
        {
            nummines++;
        }
         if (isValid(row-1,col+1) == true && mines.contains(buttons[row-1][col+1]))
        {
            nummines++;
        }
         if (isValid(row-1,col-1) == true && mines.contains(buttons[row-1][col-1]))
        {
            nummines++;
        }
         if (isValid(row+1,col+1) == true && mines.contains(buttons[row+1][col+1]))
        {
            nummines++;
        }
         if (isValid(row+1,col-1) == true && mines.contains(buttons[row+1][col-1]))
        {
            nummines++;
        }
        return nummines;
    }
}
