"use client"
import React from 'react'

const LoginCard = ({children,cardtitle}) => {
  return (
    <div className='w-[444px] h-fit bg-white shadow-lg flex flex-col rounded-[6px] '>
        <img src='./logo.png'className='self-center mt-[35.5px] w-[112px] h-[112px]'/>
        <p className='text-[4B465C] text-[20px] text-center mt-[29.5px]'>{cardtitle}</p>
        {children}
    </div>
  )
}

export default LoginCard