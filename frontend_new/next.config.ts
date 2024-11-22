// import type { NextConfig } from "next";

// const nextConfig: NextConfig = {
//   /* config options here */
//   // useFileSystemPublicRoutes: false,
//   async rewrites() {
//     return [
//       {
//         source: "/api/v1/:path*/",
//         destination: "http://backend:6666/api/v1/:path*",  // 항상 6666 포트 사용
//         // destination:
//         //   process.env.NODE_ENV === "development"
//         //     ? "http://backend:6666/api/v1/:path*/"
//         //     : "http://backend/api/v1/:path*/",
//       },
//     ];
//   },
//   trailingSlash: true,
//   // output: "standalone", // standalone 모드 활성화
// };

// export default nextConfig;

import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  /* config options here */
  async rewrites() {
    if (process.env.NODE_ENV === 'development') {
      // 로컬 Docker Compose 개발 환경
      return [
        {
          source: "/api/v1/:path*/",
          destination: "http://backend:6666/api/v1/:path*/",
        },
      ];
    } else {
      // Production (Kubernetes with Ingress) 환경
      const API_URL = process.env.NEXT_PUBLIC_API_URL || '/api/v1/';
      return [
        {
          source: "/api/v1/:path*/",
          destination: `${API_URL}/:path*/`,
        },
      ];
    }
  },
  trailingSlash: true,
};

export default nextConfig;


