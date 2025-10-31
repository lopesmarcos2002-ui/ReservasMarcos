import { Header } from "@/components/header"
import { HeroSearch } from "@/components/hero-search"
import { FeaturedHotels } from "@/components/featured-hotels"
import { Features } from "@/components/features"
import { Footer } from "@/components/footer"

export default function Home() {
  return (
    <div className="min-h-screen flex flex-col">
      <Header />
      <main className="flex-1">
        <HeroSearch />
        <FeaturedHotels />
        <Features />
      </main>
      <Footer />
    </div>
  )
}
