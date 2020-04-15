/*import kx.c;*/
import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Scanner;
import kx.c;
import kx.c.KException;

public class csvLoad {

	private static final String[] COL_NAMES 
		= new String[] { "time", "sym", "price", "size", "exchange" };

    public static void main(String[] args) {
        String fileName= "trade.csv";
        File file= new File(fileName);


        // this gives you a 2-dimensional array of strings
        List<List<String>> lines = new ArrayList<>();
        Scanner inputStream;

        try{
            inputStream = new Scanner(file);

            while(inputStream.hasNext()){
                String line= inputStream.next();
                String[] values = line.split(",");
                // this adds the currently parsed line to the 2-dimensional string array
                lines.add(Arrays.asList(values));
            }

            inputStream.close();
        }catch (FileNotFoundException e) {
            e.printStackTrace();
        }

        List<String> time = new ArrayList<String>();
        List<String> sym = new ArrayList<String>();
        List<String> price = new ArrayList<String>();
        List<String> size = new ArrayList<String>();
        List<String> exchange = new ArrayList<String>();
        // the following code lets you iterate through the 2-dimensional array
        int lineNo = 1;
        for(List<String> line: lines) {
            int columnNo = 1;
            for (String value: line) {
            	if(columnNo == 1){time.add(value);}
            	if(columnNo == 2){sym.add(value);}
            	if(columnNo == 3){size.add(value);}
            	if(columnNo == 4){price.add(value);}
            	if(columnNo == 5){exchange.add(value);}
                //System.out.println("Line " + lineNo + " Column " + columnNo + ": " + value);
                columnNo++;
            }
            lineNo++;
        }

        String[] times = new String[size.size()];
        String[] syms = new String[size.size()];
        int[] sizes = new int[size.size()];
        double[] prices = new double[size.size()];
        String[] exchanges = new String[size.size()];

        for(int i = 0; i < size.size(); i++){

        	times[i] = time.get(i);
        	syms[i] = sym.get(i);
        	sizes[i]= Integer.valueOf(size.get(i));
        	prices[i] = Double.valueOf(price.get(i));
        	exchanges[i] = exchange.get(i);
        }

        Object[] data = new Object[] { times, syms, prices, sizes, exchanges };
		c.Flip tab = new c.Flip(new c.Dict(COL_NAMES, data));

		Object[] updStatement = new Object[] { "upd_java", "trade", tab };

		c c = null;		
		try {

			c = new c("localhost", 5010,"username:password");
			c.ks(updStatement); // send asynchronously
			System.out.println("Sent records to KDB server");

		} catch(Exception ex) {
			System.err.println("error sending feed to server.");
		}
		
        System.out.println(times[2]);
    }

}