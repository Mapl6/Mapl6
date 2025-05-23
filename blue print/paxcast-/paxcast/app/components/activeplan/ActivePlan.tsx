"use client";
import React, { useState } from "react";
import { Progress } from "@nextui-org/progress";
import {
  Modal,
  ModalContent,
  ModalHeader,
  ModalBody,
  ModalFooter,
  useDisclosure,
} from "@nextui-org/modal";
const ActivePlan = () => {
  const { isOpen, onOpen, onOpenChange } = useDisclosure();
  const [counter, setCounter] = useState(1);

  const increase = () => {
    setCounter((count) => count + 1);
  };


  const decrease = () => {
    if (counter >= 2) {
      setCounter((count) => count - 1);
    }
  };


  return (
    <div className="px-[24px] py-[22px] border-[1px] rounded-md border-[#DBDADE] w-full justify-between">
      <h1 className="text-[24px] text-[#021D48] font-bold">اشتراک فعال</h1>
      <div className="flex justify-between">
        <div className="text-[16px] text-[#4B465C] flex flex-col gap-3 w-2/5">
          <div className="flex gap-1">
            <span className=""> اشتراک فعلی شما : </span>
            <svg
              width="40"
              height="24"
              viewBox="0 0 40 24"
              fill="none"
              xmlns="http://www.w3.org/2000/svg"
            >
              <rect
                width="40"
                height="24"
                rx="4"
                fill="#28C76F"
                fill-opacity="0.16"
              />
              <path
                d="M16.4683 15C15.9562 15 15.5055 14.9006 15.1162 14.7017C14.7269 14.4985 14.4328 14.2023 14.2339 13.813H13.2563C12.3084 13.813 11.5911 13.6331 11.1045 13.2734C10.6221 12.9137 10.3809 12.4377 10.3809 11.8452C10.3809 11.1724 10.6369 10.6328 11.1489 10.2266C11.6652 9.82031 12.4185 9.5262 13.4087 9.34424L13.5864 9.31885L13.561 9.13477L13.5356 8.89355L13.7769 8.84912L14.7798 8.69043L15.04 8.65234L15.0718 8.9126L15.5034 12.5435C15.5584 12.8693 15.66 13.0851 15.8081 13.1909C15.9562 13.2967 16.1995 13.3496 16.5381 13.3496H16.7603C16.8068 13.3496 16.8449 13.4385 16.8745 13.6162C16.9041 13.7939 16.9189 13.9653 16.9189 14.1304V14.2002C16.9189 14.3737 16.9041 14.5514 16.8745 14.7334C16.8491 14.9111 16.811 15 16.7603 15H16.4683ZM13.9292 12.207L13.7705 10.9375L13.6626 10.9502C13.2902 11.0052 12.9686 11.0793 12.6978 11.1724C12.4312 11.2655 12.2365 11.3628 12.1138 11.4644C11.991 11.5659 11.9297 11.6654 11.9297 11.7627C11.9297 11.9023 12.0186 12.0124 12.1963 12.0928C12.3783 12.1689 12.6999 12.207 13.1611 12.207H13.9292ZM18.5186 17.1011L19.585 16.0283L20.6577 17.1011C20.6323 17.1265 20.6069 17.154 20.5815 17.1836C20.5265 17.2386 20.3784 17.3846 20.1372 17.6216C19.896 17.8628 19.7119 18.0469 19.585 18.1738L18.5186 17.1011ZM16.2207 17.1011L17.2935 16.0283L18.3599 17.1011L17.2935 18.1738L16.2207 17.1011ZM16.7031 13.3496H18.4995C18.8973 13.3496 19.1681 13.2861 19.312 13.1592C19.4559 13.0322 19.5278 12.772 19.5278 12.3784V10.5122V10.2583H19.7817H20.8862H21.1401V10.5122V12.3848C21.1401 13.2311 20.9137 13.8786 20.4609 14.3271C20.0124 14.7757 19.3607 15 18.5059 15H16.7031C16.6523 15 16.6143 14.9111 16.5889 14.7334C16.5592 14.5514 16.5444 14.3737 16.5444 14.2002V14.1304C16.5444 13.9653 16.5592 13.7939 16.5889 13.6162C16.6185 13.4385 16.6566 13.3496 16.7031 13.3496ZM24.8535 15H24.5615C23.804 15 23.2264 14.7736 22.8286 14.3208C22.4351 13.8638 22.2383 13.2121 22.2383 12.3657V6.79248V6.53857H22.4922H23.5459H23.7998V6.79248V12.3721C23.7998 12.7275 23.8612 12.9793 23.9839 13.1274C24.1108 13.2756 24.3097 13.3496 24.5806 13.3496H24.8535C24.9001 13.3496 24.9382 13.4385 24.9678 13.6162C24.9974 13.7939 25.0122 13.9653 25.0122 14.1304V14.2002C25.0122 14.3737 24.9974 14.5514 24.9678 14.7334C24.9424 14.9111 24.9043 15 24.8535 15ZM25.5264 18.4341L26.5483 17.4121L27.564 18.4341L26.5483 19.4434L25.5264 18.4341ZM26.6816 16.8662L27.6973 15.8569L28.7192 16.8662L27.6973 17.8882L26.6816 16.8662ZM24.3711 16.8662L25.3931 15.8569L26.4087 16.8662L25.3931 17.8882L24.3711 16.8662ZM24.79 13.3496H26.5864C26.9842 13.3496 27.255 13.2861 27.3989 13.1592C27.5428 13.0322 27.6147 12.772 27.6147 12.3784V10.5122V10.2583H27.8687H28.9731H29.2271V10.5122V12.3848C29.2271 13.2311 29.0007 13.8786 28.5479 14.3271C28.0993 14.7757 27.4476 15 26.5928 15H24.79C24.7393 15 24.7012 14.9111 24.6758 14.7334C24.6462 14.5514 24.6313 14.3737 24.6313 14.2002V14.1304C24.6313 13.9653 24.6462 13.7939 24.6758 13.6162C24.7054 13.4385 24.7435 13.3496 24.79 13.3496Z"
                fill="#28C76F"
              />
            </svg>
          </div>
          <span>فعال تا 12 خرداد 1403</span>
        </div>
        <div className="flex flex-col w-1/3">
          <div className="text-[#4B465C] font-[22px] flex justify-between w-full ">
            <span>روز ها</span>
            <span>24 روز از 30 روز</span>
          </div>
          <Progress
            size="md"
            value={90}
            className="max-w-md"
          />
          <span className="text-[#A0A0A0]">
            اشتراک شما نیاز به بروزرسانی دارد{" "}
          </span>
          <button
            onClick={onOpen}
            className="px-[28px] py-[8px] w-fit h-fit text-white bg-[#328CBE] text-[15px] rounded-md"
          >
            بروزرسانی اشتراک
          </button>
          </div>
          </div>
          <Modal isOpen={isOpen} onOpenChange={onOpenChange}>
            <ModalContent>
              {(onClose) => (
                <>
                  <ModalHeader className="flex flex-col gap-1 text-[24px] text-[#021D48] ">
                    بروزرسانی شتراک{" "}
                  </ModalHeader>
                  <ModalBody>
                    <div className="text-[16px] text-[#4B465C] flex flex-col gap-3  ">
                      <div className="flex gap-1">
                        <span className="font-bold"> اشتراک فعلی شما : </span>
                        <svg
                          width="40"
                          height="24"
                          viewBox="0 0 40 24"
                          fill="none"
                          xmlns="http://www.w3.org/2000/svg"
                        >
                          <rect
                            width="40"
                            height="24"
                            rx="4"
                            fill="#28C76F"
                            fill-opacity="0.16"
                          />
                          <path
                            d="M16.4683 15C15.9562 15 15.5055 14.9006 15.1162 14.7017C14.7269 14.4985 14.4328 14.2023 14.2339 13.813H13.2563C12.3084 13.813 11.5911 13.6331 11.1045 13.2734C10.6221 12.9137 10.3809 12.4377 10.3809 11.8452C10.3809 11.1724 10.6369 10.6328 11.1489 10.2266C11.6652 9.82031 12.4185 9.5262 13.4087 9.34424L13.5864 9.31885L13.561 9.13477L13.5356 8.89355L13.7769 8.84912L14.7798 8.69043L15.04 8.65234L15.0718 8.9126L15.5034 12.5435C15.5584 12.8693 15.66 13.0851 15.8081 13.1909C15.9562 13.2967 16.1995 13.3496 16.5381 13.3496H16.7603C16.8068 13.3496 16.8449 13.4385 16.8745 13.6162C16.9041 13.7939 16.9189 13.9653 16.9189 14.1304V14.2002C16.9189 14.3737 16.9041 14.5514 16.8745 14.7334C16.8491 14.9111 16.811 15 16.7603 15H16.4683ZM13.9292 12.207L13.7705 10.9375L13.6626 10.9502C13.2902 11.0052 12.9686 11.0793 12.6978 11.1724C12.4312 11.2655 12.2365 11.3628 12.1138 11.4644C11.991 11.5659 11.9297 11.6654 11.9297 11.7627C11.9297 11.9023 12.0186 12.0124 12.1963 12.0928C12.3783 12.1689 12.6999 12.207 13.1611 12.207H13.9292ZM18.5186 17.1011L19.585 16.0283L20.6577 17.1011C20.6323 17.1265 20.6069 17.154 20.5815 17.1836C20.5265 17.2386 20.3784 17.3846 20.1372 17.6216C19.896 17.8628 19.7119 18.0469 19.585 18.1738L18.5186 17.1011ZM16.2207 17.1011L17.2935 16.0283L18.3599 17.1011L17.2935 18.1738L16.2207 17.1011ZM16.7031 13.3496H18.4995C18.8973 13.3496 19.1681 13.2861 19.312 13.1592C19.4559 13.0322 19.5278 12.772 19.5278 12.3784V10.5122V10.2583H19.7817H20.8862H21.1401V10.5122V12.3848C21.1401 13.2311 20.9137 13.8786 20.4609 14.3271C20.0124 14.7757 19.3607 15 18.5059 15H16.7031C16.6523 15 16.6143 14.9111 16.5889 14.7334C16.5592 14.5514 16.5444 14.3737 16.5444 14.2002V14.1304C16.5444 13.9653 16.5592 13.7939 16.5889 13.6162C16.6185 13.4385 16.6566 13.3496 16.7031 13.3496ZM24.8535 15H24.5615C23.804 15 23.2264 14.7736 22.8286 14.3208C22.4351 13.8638 22.2383 13.2121 22.2383 12.3657V6.79248V6.53857H22.4922H23.5459H23.7998V6.79248V12.3721C23.7998 12.7275 23.8612 12.9793 23.9839 13.1274C24.1108 13.2756 24.3097 13.3496 24.5806 13.3496H24.8535C24.9001 13.3496 24.9382 13.4385 24.9678 13.6162C24.9974 13.7939 25.0122 13.9653 25.0122 14.1304V14.2002C25.0122 14.3737 24.9974 14.5514 24.9678 14.7334C24.9424 14.9111 24.9043 15 24.8535 15ZM25.5264 18.4341L26.5483 17.4121L27.564 18.4341L26.5483 19.4434L25.5264 18.4341ZM26.6816 16.8662L27.6973 15.8569L28.7192 16.8662L27.6973 17.8882L26.6816 16.8662ZM24.3711 16.8662L25.3931 15.8569L26.4087 16.8662L25.3931 17.8882L24.3711 16.8662ZM24.79 13.3496H26.5864C26.9842 13.3496 27.255 13.2861 27.3989 13.1592C27.5428 13.0322 27.6147 12.772 27.6147 12.3784V10.5122V10.2583H27.8687H28.9731H29.2271V10.5122V12.3848C29.2271 13.2311 29.0007 13.8786 28.5479 14.3271C28.0993 14.7757 27.4476 15 26.5928 15H24.79C24.7393 15 24.7012 14.9111 24.6758 14.7334C24.6462 14.5514 24.6313 14.3737 24.6313 14.2002V14.1304C24.6313 13.9653 24.6462 13.7939 24.6758 13.6162C24.7054 13.4385 24.7435 13.3496 24.79 13.3496Z"
                            fill="#28C76F"
                          />
                        </svg>
                      </div>
                      <span>فعال تا 12 خرداد 1403</span>
                    </div>
                    <div className="flex justify-between">
                      <span className="text-[#4B465C] text-[16px] font-bold">
                        افزایش به مدت{" "}
                      </span>
                      <div className="flex gap-4">
                        <button
                          className="w-[36px] h-[36px] rounded-md bg-[#DBDADE] text-[24px]"
                          onClick={increase}
                        >
                          +
                        </button>
                        <span className="border-1 border-[#A0A0A0] w-[51px] h-[38px] rounded-md text-center content-center">
                          {" "}
                          {counter} ماه{" "}
                        </span>
                        <button
                          className="w-[36px] h-[36px] rounded-md bg-[#DBDADE] text-[24px]"
                          onClick={decrease}
                        >
                          -
                        </button>
                      </div>
                    </div>
                     
                  </ModalBody>
                  <ModalFooter className="">
                    <button
                      onClick={onOpen}
                      className="px-[143px] py-[8px] w-fit h-fit text-white bg-[#328CBE] text-[15px] rounded-md"
                    >
                      درخواست
                    </button>
                  </ModalFooter>
                </>
              )}
            </ModalContent>
          </Modal>
    </div>
  );
};

export default ActivePlan;
