using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EarthRotationandMovement : MonoBehaviour
{

    public bool IsGrabbed = false;
    public float AutopRotationSpeed = 10f;
    public float GrabRotationSpeed = 50f;
    private Vector2 joystickpos;
    public Transform cam;
    public GameObject canvas;



    // Start is called before the first frame update
    void Start()
    {

    }

    // Update is called once per frame
    void Update()
    {
        joystickpos = OVRInput.Get(OVRInput.Axis2D.PrimaryThumbstick);

        if(joystickpos.x != 0f || joystickpos.y != 0f)
            IsGrabbed = true;
        else
            IsGrabbed = false;


        if (IsGrabbed)
            GrabRotate();
        else
            AutoRotate();

        Movement();

        OpenMenu();
    }

    private void AutoRotate()
    {
        if (Vector3.Dot(transform.up, Vector3.up) >= 0)
        {
            this.transform.Rotate(0, AutopRotationSpeed * Time.deltaTime, 0);
        }
        else
        {
            this.transform.Rotate(0, -AutopRotationSpeed * Time.deltaTime, 0);

        }
    }

    private void GrabRotate()
    {

        this.transform.Rotate(joystickpos.y * GrabRotationSpeed * Time.deltaTime, -joystickpos.x * GrabRotationSpeed * Time.deltaTime, 0);

       
    }

    private void Movement()
    {
        Vector2 rightjoystickpos = OVRInput.Get(OVRInput.Axis2D.SecondaryThumbstick);

        Vector3 CamF = cam.forward;
        Vector3 CamR = cam.right;

        CamF.y = 0;
        CamR.y = 0;
        CamF = CamF.normalized;
        CamR = CamR.normalized;

        Vector3 faketransformcheck = this.transform.position + (CamF * rightjoystickpos.y + CamR * rightjoystickpos.x) * Time.deltaTime * 5;
        if (faketransformcheck.x <= 10 && faketransformcheck.x >= -10 && faketransformcheck.z <= 10 && faketransformcheck.z >= -10)
        this.transform.position += (CamF * rightjoystickpos.y + CamR * rightjoystickpos.x)*Time.deltaTime*5;


        if(OVRInput.Get(OVRInput.RawButton.RHandTrigger))
        {
            Vector3 faketransformYpos = this.transform.position + new Vector3(0, 1 * Time.deltaTime, 0);
            
            if(faketransformYpos.y <= 10)
                this.transform.position += new Vector3(0, 1*Time.deltaTime, 0);
        }

        if (OVRInput.Get(OVRInput.RawButton.LHandTrigger))
        {
            Vector3 faketransformYneg = this.transform.position + new Vector3(0, -1 * Time.deltaTime, 0);

            if (faketransformYneg.y >= -10)
                this.transform.position += new Vector3(0, -1 * Time.deltaTime, 0);
        }

    }

    private void OpenMenu()
    {
        if(OVRInput.GetDown(OVRInput.RawButton.A)|| OVRInput.GetDown(OVRInput.RawButton.X))
        {
            if(!canvas.activeSelf)
                canvas.SetActive(true);
        }
    }
}
