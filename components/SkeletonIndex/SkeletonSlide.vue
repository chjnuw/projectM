<template>
  <div class="relative w-full sm:h-[80vh] lg:h-[100vh] overflow-hidden bg-neutral-900 animate-pulse">

    <!-- Desktop Skeleton -->
    <div class="hidden lg:flex h-full items-center px-10">
      <div class="w-1/3 space-y-6">
        <SkeletonCatagoryShimmer class="h-10 bg-neutral-700 rounded w-3/4"></SkeletonCatagoryShimmer>
        <Shimmer class="h-6 bg-neutral-700 rounded w-1/2"></Shimmer>

        <div class="flex gap-3">
          <SkeletonCatagoryShimmer class="h-6 w-16 bg-neutral-700 rounded"></SkeletonCatagoryShimmer>
          <Shimmer class="h-6 w-20 bg-neutral-700 rounded"></Shimmer>
        </div>

        <div class="space-y-2">
          <SkeletonCatagoryShimmer class="h-4 bg-neutral-700 rounded w-full"></SkeletonCatagoryShimmer>
          <SkeletonCatagoryShimmer class="h-4 bg-neutral-700 rounded w-5/6"></SkeletonCatagoryShimmer>
          <SkeletonCatagoryShimmer class="h-4 bg-neutral-700 rounded w-4/6"></SkeletonCatagoryShimmer>
        </div>

        <div class="flex gap-4 pt-4">
             <SkeletonCatagoryShimmer class="h-12 w-40 bg-neutral-700 rounded-xl"></SkeletonCatagoryShimmer>
          <SkeletonCatagoryShimmer class="h-12 w-40 bg-neutral-700 rounded-xl"></SkeletonCatagoryShimmer>
        </div>
      </div>
    </div>

    <!-- Mobile Skeleton -->
    <div class="lg:hidden p-5 space-y-4">
      <SkeletonCatagoryShimmer class="aspect-[2/3] bg-neutral-700 rounded-xl"></SkeletonCatagoryShimmer>

      <div class="space-y-3">
        <SkeletonCatagoryShimmer class="h-6 bg-neutral-700 rounded w-3/4"></SkeletonCatagoryShimmer>
        <SkeletonCatagoryShimmer class="h-4 bg-neutral-700 rounded w-1/2"></SkeletonCatagoryShimmer>

        <div class="flex gap-2">
          <SkeletonCatagoryShimmer class="h-5 w-14 bg-neutral-700 rounded"></SkeletonCatagoryShimmer>
          <SkeletonCatagoryShimmer class="h-5 w-20 bg-neutral-700 rounded"></SkeletonCatagoryShimmer>
        </div>

        <div class="space-y-2">
          <SkeletonCatagoryShimmer class="h-3 bg-neutral-700 rounded w-full"></SkeletonCatagoryShimmer>
          <SkeletonCatagoryShimmer class="h-3 bg-neutral-700 rounded w-5/6"></SkeletonCatagoryShimmer>
          <SkeletonCatagoryShimmer class="h-3 bg-neutral-700 rounded w-4/6"></SkeletonCatagoryShimmer>
        </div>

        <div class="flex gap-3 pt-3">
          <SkeletonCatagoryShimmer class="flex-1 h-10 bg-neutral-700 rounded-lg"></SkeletonCatagoryShimmer>
          <SkeletonCatagoryShimmer class="flex-1 h-10 bg-neutral-700 rounded-lg"></SkeletonCatagoryShimmer>
        </div>
      </div>
    </div>

  </div>
</template>
