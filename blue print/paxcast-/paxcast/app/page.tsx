import Image from "next/image";
import SidebaraMain from './components/sidebar/SidebaraMain'
import PlanCard from "./components/plancard/PlanCard";
import ActivePlan from "./components/activeplan/ActivePlan";
import Login from "./(Auth)/login/Login";
import OTPpage from "./(Auth)/login/OTPpage";
import { NextUIProvider } from "@nextui-org/system";
export default function Home() {
  return (
      <NextUIProvider>
    <main className="flex min-h-screen items-center justify-between font-shabnam  ">
<SidebaraMain/> 
<div className="w-full h-full p-8 flex flex-col gap-8">
  <PlanCard/>
  <ActivePlan/>
</div>
{/* <Login/> */}
{/* <OTPpage/> */}
    </main>
</NextUIProvider>
  );
}
