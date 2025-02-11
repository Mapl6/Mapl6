"use client"
import React, { useState, useEffect } from 'react'
import LoginCard from './LoginCard'
// import { BaseURL } from '../../constants/global';
// import { useNavigate } from 'react-router-dom';


const Login = () => {
  const navigate = ""

  const [isLoading, setIsLoading] = useState(true);
  const [phoneNumber, setPhoneNumber] = useState('');
  const [isPhoneNumberValid, setIsPhoneNumberValid] = useState(false);
  const [showPhoneNumberError, setShowPhoneNumberError] = useState(false);


  const handlePhoneNumberChange = (e) => {
    const newPhoneNumber = e.target.value;
    setPhoneNumber(newPhoneNumber);
    setIsPhoneNumberValid(newPhoneNumber.trim().length === 11);
    setShowPhoneNumberError(false);
  }

  const handleLogin = async () => {
    // try {

    //   const response = await fetch(`${BaseURL}users/login/`, {
    //     method: 'POST',
    //     headers: {
    //       'Content-Type': 'application/json',
    //     },
    //     body: JSON.stringify({
    //       "phone_number": phoneNumber,
    //     }),
    //   });

    //   const data = await response.json();
    //   console.log(data);

    //   if (response.ok) {

    //     navigate('/opt');
    //   } else {
    //     console.error('Error:', data.error);
    //   }
    // } catch (error) {
    //   console.error('Error:', error);
    // } finally {
    //   setIsLoading(false);
    // }
  };

  const handleKeyPress = (e) => {
    if (e.key === 'Enter') {
      handleLogin();
    }
  }

  useEffect(() => {
    // No need to fetch data here, as the login process is handled in the handleLogin function
  }, []);

  return (
    <div className='flex flex-col justify-start w-screen h-screen'>
      <img src='./image.png' className='w-[475px] h-[351px] self-end'/>
      {/* do not forget edit bg image */}
    <div className='loginbg bg-cover flex justify-center rounded-[6px]'>

      <div className=' self-center'>
        <LoginCard cardtitle="ورود به پنل مرکز تصویر برداری پکس کست">
          <input
            placeholder='شماره همراه خود را وارد کنید'
            className='w-[388px] self-center rounded-[6px] border-[1px] border-[#fff]/opacity-20 mt-[16.5px] py-[7px] px-[14px]'
            value={phoneNumber}
            onChange={handlePhoneNumberChange}
            onKeyPress={handleKeyPress}
          />
          <button
            className={`bg-[#A8AAAE29] text-[#A8AAAE29] w-[388px] self-center mt-[16px] rounded-[6px] h-auto px-5 py-2.5 ${isPhoneNumberValid ? 'bg-blue-500 text-white' : ''}`}
            onClick={handleLogin}
          >
            ورود
          </button>
          {showPhoneNumberError && (
            <div className="text-red-500 mt-2">
              Please enter a valid 11-digit phone number.
            </div>
          )}
          <span className='pb-[44.5px]' />
        </LoginCard>
      </div>
    </div>
    <img src='./image1.png' className='w-[475px] h-[351px] self-start'/>

    </div>
  )
}

export default Login