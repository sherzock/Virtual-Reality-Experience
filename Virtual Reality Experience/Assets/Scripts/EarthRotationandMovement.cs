using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EarthRotationandMovement : MonoBehaviour
{

    public bool IsGrabbed = false;
    public bool CanStartGrab = false;
    public bool IsRotating = true;
    public float RotationSpeed = 0.1f;

    Vector3 mPrevPos = Vector3.zero;
    Vector3 mPosDelta = Vector3.zero;


    // Start is called before the first frame update
    void Start()
    {

    }

    // Update is called once per frame
    void Update()
    {
        
        if (IsRotating)
            AutoRotate();

        if (CanStartGrab)
        {
                IsGrabbed = true;
        }

        if (IsGrabbed)
            GrabRotate();
    }

    private void OnMouseOver()
    {
        CanStartGrab = true;
    }

    private void OnMouseExit()
    {
        CanStartGrab = false;
    }

    private void AutoRotate()
    {
        if (Vector3.Dot(transform.up, Vector3.up) >= 0)
        {
            this.transform.Rotate(0, RotationSpeed * Time.deltaTime, 0);
        }
        else
        {
            this.transform.Rotate(0, -RotationSpeed * Time.deltaTime, 0);

        }
    }

    private void GrabRotate()
    {
            if(Input.GetMouseButtonUp(0))
        {
            IsRotating= true;
            IsGrabbed = false;
        }
        
        if (Input.GetMouseButton(0))
        {
            IsRotating = false;

            mPosDelta = Input.mousePosition - mPrevPos;
            if (Vector3.Dot(transform.up, Vector3.up) >= 0)
            {
                transform.Rotate(transform.up, -Vector3.Dot(mPosDelta, Camera.main.transform.right), Space.World);
            }
            else
            {
                transform.Rotate(transform.up, Vector3.Dot(mPosDelta, Camera.main.transform.right), Space.World);
            }

            transform.Rotate(Camera.main.transform.right, Vector3.Dot(mPosDelta, Camera.main.transform.up), Space.World);
        }
            mPrevPos = Input.mousePosition;
    }
}
