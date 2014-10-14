package mapred;
import java.io.IOException;
import java.util.*;

import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.io.Writable;
import org.apache.hadoop.io.WritableComparable;
import org.apache.hadoop.mapred.FileSplit;
import org.apache.hadoop.mapred.MapReduceBase;
import org.apache.hadoop.mapred.Mapper;
import org.apache.hadoop.mapred.OutputCollector;
import org.apache.hadoop.mapred.Reporter;

/*
 * Modified by: Manish Sapkota to create inverted indexing of the histogram features of image
 */

public class IndexMapper extends MapReduceBase implements Mapper<LongWritable,Text,Text,Text> {

	@Override
	public void map(LongWritable key, Text value, OutputCollector<Text, Text> output, Reporter reporter)
			throws IOException {

		String imageName = "";

		String line = value.toString();

		StringTokenizer tokenizer = new StringTokenizer(line);
		Float val=0.0f;
		Integer count=0;
		while(tokenizer.hasMoreTokens()){
			String token = tokenizer.nextToken();
			if(count==0)
			{
				imageName=token;
				count++;
				continue;
			}
			
			if(token!=""){
				val=Float.parseFloat(token);
				if(val>0)
				{
					output.collect(new Text(count.toString()), new Text(imageName+":"+token));
				}// end if val>0
			}// end if token!=""
			count++;
		}// end while
	}//end map
}
