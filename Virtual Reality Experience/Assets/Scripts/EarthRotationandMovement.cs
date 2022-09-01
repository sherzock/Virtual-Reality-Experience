using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EarthRotationandMovement : MonoBehaviour
{

    public bool IsGrabbed = false;
    public bool IsRotating = true;
    public float RotationSpeed = 0.1f;


    // Start is called before the first frame update
    void Start()
    {
        //IsGrabbed = false;
        //IsRotating = true;
    }

    // Update is called once per frame
    void Update()
    {
        if (IsRotating)
            Rotate();
    }


    private void Rotate()
    {
        this.transform.Rotate(0, RotationSpeed, 0);
    }
}
