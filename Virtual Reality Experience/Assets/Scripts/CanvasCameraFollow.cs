using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CanvasCameraFollow : MonoBehaviour
{

    public GameObject camera;

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        gameObject.transform.position = new Vector3(gameObject.transform.position.x, camera.transform.position.y, gameObject.transform.position.z);
    }
}
