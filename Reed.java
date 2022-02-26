import java.io.Serializable;

class Reed implements Serializable {
  public float reedWidth, reedHeight;
  public int slotNumber;
  public float slotWidth, slotHeight, slotSpacing, heddleWidth;
  Reed() {
  }
  Reed(float _reedWidth, float _reedHeight, int _slotNumber, float _slotWidth, float _slotHeight, float _slotSpacing, float _heddleWidth) {
    reedWidth=_reedWidth;
    reedHeight=_reedHeight;
    slotNumber=_slotNumber;
    slotWidth=_slotWidth;
    slotHeight=_slotHeight;
    slotSpacing=_slotSpacing;
    heddleWidth=_heddleWidth;
  }
  

};
