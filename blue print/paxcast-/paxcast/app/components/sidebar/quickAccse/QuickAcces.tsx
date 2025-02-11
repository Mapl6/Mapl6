import React, { useState } from 'react';
import TopHeading from '../TopHeading';
import QuickAccesBtn from './QuickAccesBtn';
// import { useNavigate } from 'react-router-dom';

const QuickAcces = ({ onButtonClick }) => {
    const [selectedButton, setSelectedButton] = useState("");
    // const navigate=useNavigate()
    const navigate=""

    const handleButtonClick = (btnTitle) => {
        setSelectedButton(btnTitle);
        onButtonClick(btnTitle);
    };


    return (
        <div className='flex flex-col gap-[16px]'>
            <TopHeading title="دسترسی های سریع"/>

                <QuickAccesBtn btnTitle="اشتراک ها" onClick={handleButtonClick} type='primary'/>

            <QuickAccesBtn btnTitle="خروج" onClick={()=>{localStorage.removeItem('at'); navigate('/login')}}/>
        </div>
    );
};

export default QuickAcces;
