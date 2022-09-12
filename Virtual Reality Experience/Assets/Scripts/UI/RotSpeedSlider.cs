using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class RotSpeedSlider : MonoBehaviour
{

    public EarthRotationandMovement earthMov;
    public Slider slid;
    public TMPro.TextMeshProUGUI speedtext;

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    public void SpeedChange()
    {
        earthMov.RotationSpeed = slid.value ;
        speedtext.text = "" + slid.value ;
    }
}
