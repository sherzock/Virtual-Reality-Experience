using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class StartButton : MonoBehaviour
{
   public GameObject MainMenu;
   public GameObject InfoMenu;
   public GameObject Earth;

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    public void StartExperience()
    {
        MainMenu.SetActive(false);
        InfoMenu.SetActive(true);
    }
}
