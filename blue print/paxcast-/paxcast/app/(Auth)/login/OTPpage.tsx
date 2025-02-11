"use client"
import React, { useRef, useState, useEffect } from 'react';
import LoginCard from './LoginCard';
// import { BaseURL } from '../../constants/global';
// import { useNavigate } from 'react-router-dom';

const OTPpage = () => {
  const navigate=""
  const [otp, setOTP] = useState('');
  const inputRefs = useRef([]);
  const [loginToken, setLoginToken] = useState();




  const handleChange = (index, value) => {
    if (value.length <= 1) {
      setOTP((prevOTP) => {
        const otpArray = prevOTP.split('');
        otpArray[index] = value;
        return otpArray.join('');
      });

      if (value && index < inputRefs.current.length - 1) {
        inputRefs.current[index + 1].focus();
      }
    }
  };

  const handlePaste = (event) => {
    event.preventDefault();
    const pastedData = event.clipboardData.getData('text/plain').trim();
    if (/^\d+$/.test(pastedData) && pastedData.length <= 6) {
      setOTP(pastedData.substring(0, 6));
    }
  };

  const handleKeyDown = (event, index) => {
    if (event.key === 'Backspace' && !otp[index] && index > 0) {
      inputRefs.current[index - 1].focus();
    }
  };

  const handleFocus = (index) => {
    if (otp.length === index && index > 0) {
      inputRefs.current[index - 1].focus();
    }
  };


const handleSubmit = async () => {
  // try {
  //   const response = await fetch(`${BaseURL}users/verify/`, {
  //     method: 'POST',
  //     headers: {
  //       'Content-Type': 'application/json',
  //     },
  //     body: JSON.stringify({
  //       code: otp,
  //       phone_number: '09120190902',
  //     }),
  //   });

  //   const data = await response.json();


  //   if (data.token) {
  //     localStorage.setItem("at",data.token)
  //     navigate('/home')
  //   } else {
  //     console.error('Error:', data);
  //   }
  // } catch (error) {
  //   console.error('Error:', error);
  // }
};

  return (
    <div className='flex flex-col justify-start w-screen h-screen'>
      <img src='./image.png' className='w-[475px] h-[351px] self-end'/>
    <div className="loginbg w-screen h-screen bg-cover flex justify-center">
      <div className="self-center">
        <LoginCard cardtitle="کد ارسالی را وارد کنید">
          <p className="text-[#b7b5be] text-[15px] self-center mt-[7px]">کد 6 رقمی به شماره شما پیامک شد</p>
          <div className="flex items-center justify-center" dir="ltr">
            {Array.from({ length: 6 }, (_, index) => (
              <input
                key={index}
                type="tel"
                pattern="[0-9]"
                inputMode="numeric"
                maxLength={1}
                value={otp[index] || ''}
                onChange={(event) => handleChange(index, event.target.value)}
                onKeyDown={(event) => handleKeyDown(event, index)}
                onFocus={() => handleFocus(index)}
                ref={(ref) => (inputRefs.current[index] = ref)}
                className="w-[45px] h-[45px] mx-1 mt-[17px] text-2xl text-center rounded focus:outline-none focus:bg-gray-100 border-[1px] border-[#DBDADE]"
              />
            ))}
          </div>
          <button
            className="bg-[#A8AAAE29] w-[388px] self-center mt-[16px] rounded-[6px] h-auto px-5 py-2.5 text-zinc-400"
            onClick={handleSubmit}
          >
            تایید
          </button>
          <p className="text-[#b7b5be] text-[15px] self-center mt-[20px] pb-[44px]"> 111 ثانیه تا درخواست مجدد کد</p>
        </LoginCard>
      </div>
    </div>
    <img src='./image1.png' className='w-[475px] h-[351px] self-start'/>

    </div>
  );
};

export default OTPpage