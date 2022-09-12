using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.Audio;

public class VolumeMixerSlider : MonoBehaviour
{

    public AudioMixer audio;
    public Slider slid;
    public TMPro.TextMeshProUGUI voltext;


    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    public void VolumeSet()
    {
        audio.SetFloat("AudioVol", Mathf.Log10(slid.value) * 20 );
        voltext.text = (int)slid.value * 100 + "%";
    }
}
