import React from 'react'

const QuickAccessBtn = ({ btnTitle, onClick, type = 'secondary' }) => {
    const handleClick = () => {
        onClick(btnTitle);
    };

    const buttonStyles = type === 'primary' ? 
        'bg-[#328CBE] hover:text-[#328CBE] text-white hover:bg-white border-[#328CBE]' : 
        'text-[#328CBE] border-[#328CBE] hover:bg-[#328CBE] hover:text-white';

    return (
        <button 
            className={`border-[1px] max-w-[302px] h-[38px] rounded-[6px] flex justify-between sm:m-0 mx-[15px] ${buttonStyles}`} 
            onClick={handleClick}
        > 
            <p className='self-center pr-[12px]'>{btnTitle}</p>
            <div className='self-center pl-[12px]'>
                <svg width="18" height="18" viewBox="0 0 18 18" xmlns="http://www.w3.org/2000/svg">
                    <path d="M14.25 9L3.75 9" stroke="currentColor" strokeLinecap="round" strokeLinejoin="round"/>
                    <path d="M8.25 4.5L3.75 9" stroke="currentColor" strokeLinecap="round" strokeLinejoin="round"/>
                    <path d="M8.25 13.5L3.75 9" stroke="currentColor" strokeLinecap="round" strokeLinejoin="round"/>
                </svg>
            </div>
        </button>
    );
};

export default QuickAccessBtn;
