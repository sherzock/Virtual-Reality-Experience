using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class CloudSpeed : MonoBehaviour
{

    public Slider slid;
    public Material earthMat;
    public TMPro.TextMeshProUGUI speedtext;

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    public void ChangeSpeed()
    {
        earthMat.SetFloat("CloudSpeed", slid.value);
        float textval = Mathf.Round(slid.value * 100.0f) * 0.01f;
        speedtext.text = "" + textval;
    }
}
