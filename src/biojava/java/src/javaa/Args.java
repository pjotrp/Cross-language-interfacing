package javaa;

import java.io.File;
import java.io.IOException;

public class Args {

    public static Args parse(String[] args) throws IOException {
        boolean verbose = false;
        boolean skipTranslate = false;
        int times = 1;
        String loc = "";

        for(int i =0; i<args.length; i++) {
            String a = args[i].replaceFirst("^-{1,2}", "");
            if("verbose".equalsIgnoreCase(a) || "v".equalsIgnoreCase(a)) {
                verbose = true;
            }
            else if ("skipTranslate".equalsIgnoreCase(a)) {
                skipTranslate = true;
            }
            else if ("times".equalsIgnoreCase(a)) {
                String v = args[++i];
                times = Integer.valueOf(v);
            }
            else {
                loc = a;
            }
        }
        return new Args(verbose, skipTranslate, times, new File(loc));
    }

    private final boolean verbose;
    private final boolean skipTranslate;
    private final int times;
    private final File location;

    private Args(boolean verbose, boolean skipTranslate, int times, File location) {
        this.verbose = verbose;
        this.skipTranslate = skipTranslate;
        this.times = times;
        this.location = location;
    }

    public File getLocation() {
        return location;
    }

    public int getTimes() {
        return times;
    }

    public boolean isSkipTranslate() {
        return skipTranslate;
    }

    public boolean isVerbose() {
        return verbose;
    }
}
