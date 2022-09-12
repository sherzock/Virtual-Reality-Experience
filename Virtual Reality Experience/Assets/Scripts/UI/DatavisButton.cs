using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DatavisButton : MonoBehaviour
{

    public GameObject earth;
    public GameObject countries;
    public Material earthMat;
    public Material waterMat;
    private bool isOn = true;

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    public void TriggerButton()
    {

        if(isOn)
        {
            earth.GetComponent<MeshRenderer>().material = waterMat;
            isOn = false;
        }
        else
        {
            earth.GetComponent<MeshRenderer>().material = earthMat;
            isOn = true;
        }
        
        if(!countries.activeSelf)
            countries.SetActive(true);
        else
            countries.SetActive(false);
    }
}
