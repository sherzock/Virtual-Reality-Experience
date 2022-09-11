using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SelectedCountry : MonoBehaviour
{

    public CSVReader reader;
    public GameObject canvas;

    private void OnEnable()
    {

        if(canvas.activeSelf == false)
            canvas.SetActive(true);

        string countryName = transform.gameObject.name;
        reader.NewSelectedCountry(countryName);
    }

    // Start is called before the first frame update
    void Start()
    {
        
    }

    private void Awake()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
