String path;
int lastSaved;
Reed loadReed()
{
  String[] lines=loadStrings(path);
  println("loading reed: "+lines[0]);
  String[] parts=lines[1].split(",");
  for(int i=0;i<parts.length;i++)
    println(float(parts[i]));
  Reed r=new Reed(float(parts[0]), float(parts[1]), int(parts[2]), float(parts[3]), float(parts[4]), float(parts[5]));
  println("slot height within function: "+r.slotHeight);
  return r;
}

void saveReed()
{
  if (millis()-lastSaved>500)
  {
    lastSaved=millis();
    println("saving reed");
    PrintWriter output=createWriter(path);

    output.println("reedWidth, reedHeight, slotNumber, slotWidth, slotHeight, slotSpacing");
    String line=reed.reedWidth+ "," +reed.reedHeight+ "," +reed.slotNumber+ "," +reed.slotWidth+ "," +reed.slotHeight+ "," +reed.slotSpacing;
    println(line);
    output.println(line);
    output.flush();
    output.close();
  }
}
