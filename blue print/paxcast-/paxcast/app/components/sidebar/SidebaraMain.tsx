'use client'
import React, { useState, useEffect } from "react";
import SidebaInfo from "./info/SidebaInfo";
import QuickAcces from "./quickAccse/QuickAcces";


const SidebaraMain = ({ onChange }) => {
  const [selectedPage, setSelectedPage] = useState();
  const [reportData, setReportData] = useState();
  const [isLoading, setIsLoading] = useState(true);

  const handleButtonClick = (btnTitle) => {
    setSelectedPage(btnTitle);
    onChange(btnTitle);
  };

  // useEffect(() => {
  //   const fetchData = async () => {
  //     try {
  //       const response = await fetch(`${BaseURL}users/dashboard/`, {
  //         method: "GET",
  //         headers: {
  //           Authorization: `TOKEN ${localStorage.getItem('at')}` ,
  //         },
  //       });

  //       const data = await response.json();
  //       console.log(data);
  //       setReportData(data.patient);
  //       setIsLoading(false);
  //     } catch (error) {
  //       console.error("Error:", error);
  //       setIsLoading(false);
  //     }
  //   };

  //   fetchData();
  // }, []);

  return (
    <div className="max-w-[790px] px-[46px] pt-[18px] mt-[18px] border-l-[#DBDADE] border-l-[1px] h-[calc(100vh-50px)] bg-white ">
      {isLoading ? (
        <SidebaInfo
          name="در حال بارگذاری"
          cellphone="در حال بارگذاری"
          city="در حال بارگذاری"
        />
      ) : (
        <>
          {reportData ? (
            <SidebaInfo
              name={reportData.FirstName}




              cellphone={reportData.TelNo1}
              city=""
            />
          ) : (
            <p>خطا در ارتباط با سرور</p>
          )}
        </>
      )}
      <QuickAcces onButtonClick={handleButtonClick} />
    </div>
  );
};

export default SidebaraMain;
