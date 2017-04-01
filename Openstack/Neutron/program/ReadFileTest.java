import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

/**
 * Author: Wucheng
 * Date: 2017/4/1 12:14
 * Abstract:
 */
public class ReadFileTest {

    public static void main(String[] args) throws IOException {

        double seconds = 3.0;
        int totalRequests = 0;

        File file = new File("case0.txt");

        if (!(file.exists() && file.canRead())) {
            System.out.println("Not exit or can't read");
        }

        FileReader fileReader = null;
        BufferedReader bufferedReader = null;
        Map<String, Integer> resMap = null;

        try {
            fileReader = new FileReader(file);
            bufferedReader = new BufferedReader(fileReader);

            resMap = new HashMap<String, Integer>();

            String str;
            int count;

            while ((str = bufferedReader.readLine()) != null) {
                totalRequests++;

                if (resMap.keySet().isEmpty() || !resMap.keySet().contains(str)) {
                    resMap.put(str, 1);
                } else {
                    count = resMap.get(str) + 1;
                    resMap.put(str, count);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            fileReader.close();
            bufferedReader.close();
        }

        // ouput result
        System.out.println("totalRequests: "+totalRequests+" speed："+totalRequests/seconds);
        for (String str : resMap.keySet()) {
            System.out.println(str + " total:" + resMap.get(str) + " speed:" + resMap.get(str)/seconds);
        }
    }
}
