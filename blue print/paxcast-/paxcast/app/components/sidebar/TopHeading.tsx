import React from 'react'

const TopHeading = ({title}) => {
  return (
    <div className='flex w-[270px] pb-[20px]'>
        <div className='bg-[#328CBE] w-[118px] h-[2px] self-center'/>
        <div className='px-2 text-[#328CBE]'>{title}</div>
        <div className='bg-[#328CBE] w-[118px] h-[2px] self-center'/>

    </div>
  )
}

export default TopHeading