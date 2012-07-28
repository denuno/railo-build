<cfscript>
	System = createObject("java", "java.lang.System");
	InputStreamReader = createObject("java","java.io.InputStreamReader");
	BufferedReader = createObject("java","java.io.BufferedReader");
	br = BufferedReader.init(InputStreamReader.init(System.in));
	keepRunning = true;
	script = "";
	while (keepRunning) {
		while(isNull(inLine)) {
			inLine = br.readLine();
		}
		args = inLine.split(" ");
		switch(args[1]) {
			case "clear":
				script = "";
				break;

			case "dir": case "ls":
				dir = isNull(args[2]) ? "." : args[2];
				for(dir in directoryList(dir)) {
					System.out.println(dir);
				}
				break;

			case "exit": case "quit": case "q":
				System.out.println("Peace out!");
				keepRunning = false;
				break;

			case "":
				try{
					System.out.println(script);
					System.out.println(evaluate(script));
				} catch (any e) {
					System.out.println("error: " & e.message);
				}
				break;

			default:
				try{
					System.out.println(inLine & " = " & evaluate(inLine));
					script &= inLine;
				} catch (any e) {
					System.out.println("error: " & e.message);
				}
				break;

		}
		inLine = javaCast("null","");
	}
</cfscript>
