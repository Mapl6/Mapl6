  import React, { Children } from "react";
  import "./Icons";
  import Icons from "./Icons";
  import TopHeading from "../TopHeading";
  const SidebaInfo = ({name,cellphone,city,children,adress}) => {

    return (
      <div className="text-[#4B465C] ">

        <TopHeading title="مشخصات"/>
        {children}
        <div className="mt-2 flex flex-col gap-[18.5px]">
          <div className="flex gap-2  ">
            <div className=" self-center pr-[15.7px]">{Icons.name}</div>
            <p className=" self-center"> نام مرکز : {name}</p>
            </div>
          <div className="flex gap-2 ">
            <div className=" self-center pr-[15.7px]">{Icons.phone}</div>
            <p className=" self-center">تلفن مرکز : {cellphone}</p>
            </div>
          <div className="flex gap-2 ">
            <div className=" self-center pr-[15.7px]">{Icons.city}</div>
            <p className=" self-center">شهر : {city}</p>
            </div>
          <div className="flex gap-2 ">
            <div className=" self-center pr-[15.7px]">{Icons.adress}</div>
            <p className=" self-center">آدرس مرکز : {adress}</p>
            </div>
        </div>
      </div>
    );
  };

  export default SidebaInfo;
