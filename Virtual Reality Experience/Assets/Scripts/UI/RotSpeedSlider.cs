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

    public void AutoSpeedChange()
    {
        earthMov.AutopRotationSpeed = slid.value ;
        speedtext.text = "Default: " + slid.value ;
    }

    public void ManualSpeedChange()
    {
        earthMov.GrabRotationSpeed = slid.value;
        speedtext.text = "Manual: " + slid.value;
    }
}
