
import React from "react";

const PlanCard = () => {
  return (
    <div className="h-[623px] w-[305px] border-[#DBDADE] rounded-md border-[1px] flex flex-col gap-[16px]  p-[24px] items-center text-center">
      <div className="mt-[26px]">
        <svg
          width="152"
          height="151"
          viewBox="0 0 152 151"
          fill="none"
          xmlns="http://www.w3.org/2000/svg"
        >
          <circle
            cx="75.6667"
            cy="75.5"
            r="75.5"
            fill="#328CBE"
            fill-opacity="0.13"
          />
          <circle
            cx="75.1667"
            cy="75"
            r="50"
            fill="#328CBE"
            fill-opacity="0.21"
          />
          <path
            d="M75.6668 106.667L48.0132 72.0996C47.6807 71.684 47.5144 71.4762 47.4698 71.2257C47.4251 70.9752 47.5092 70.7228 47.6776 70.2178L53.5051 52.7351C53.9451 51.4151 54.1652 50.755 54.6889 50.3775C55.2127 50 55.9084 50 57.2999 50H94.0338C95.4252 50 96.121 50 96.6447 50.3775C97.1685 50.755 97.3885 51.4151 97.8285 52.7351L103.656 70.2178C103.824 70.7228 103.909 70.9752 103.864 71.2257C103.819 71.4762 103.653 71.684 103.32 72.0996L75.6668 106.667ZM75.6668 106.667L88.0627 67.7083M75.6668 106.667L63.271 67.7083M102.229 71.25L88.0627 67.7083M88.0627 67.7083L82.7502 53.5417M88.0627 67.7083H63.271M68.5835 53.5417L63.271 67.7083M63.271 67.7083L49.1043 71.25"
            stroke="#021D48"
            stroke-width="2"
            stroke-linecap="round"
          />
        </svg>
      </div>
      <div className="text-[#4B465C]">
        <h1 className="font-bold text-[26px] mb-[6px]">پایه</h1>
        <h4 className="">یک شروع ساده برای همه</h4>
      </div>
      <div className="flex gap-2">
        <span className="text-[#4B465C]/50 text-[15px] self-center">   ماه /   </span>{"   "}
        <div className="text-[#7367F0] flex gap-2"><span className="text-[48px]">۱۰۰</span> <span className="text-[11px] self-start mt-3 ">هزارتومان</span></div>
      </div>
<ul className="text-[15px] text-right text-[#4B465C]/80 list-disc gap-[10px] flex flex-col">
    <li>100 پاسخ در ماه</li>
    <li>فرم ها و نظرسنجی های نامحدود</li>
    <li>زمینه های نامحدود</li>
    <li>ابزارهای اولیه ایجاد فرم</li>
    <li>حداکثر 2 زیر دامنه</li>
</ul>
<button className="px-[72px] py-[10px] text-[#28C76F] bg-[#28C76F]/20 text-[15px] rounded-md">اشتراک فعلی شما</button>
    </div>
  );
};

export default PlanCard;
