; ModuleID = 'source.c'
source_filename = "source.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: nounwind uwtable
define dso_local i32 @add_sub(i32* %0) #0 {
  %2 = alloca i32*, align 8
  %3 = alloca i32, align 4
  %4 = alloca i64, align 8
  store i32* %0, i32** %2, align 8, !tbaa !2
  %5 = bitcast i32* %3 to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* %5) #2
  store i32 0, i32* %3, align 4, !tbaa !6
  %6 = bitcast i64* %4 to i8*
  call void @llvm.lifetime.start.p0i8(i64 8, i8* %6) #2
  store i64 0, i64* %4, align 8, !tbaa !8
  br label %7

7:                                                ; preds = %31, %1
  %8 = load i64, i64* %4, align 8, !tbaa !8
  %9 = icmp ult i64 %8, 1024
  br i1 %9, label %12, label %10

10:                                               ; preds = %7
  %11 = bitcast i64* %4 to i8*
  call void @llvm.lifetime.end.p0i8(i64 8, i8* %11) #2
  br label %34

12:                                               ; preds = %7
  %13 = load i64, i64* %4, align 8, !tbaa !8
  %14 = urem i64 %13, 2
  %15 = icmp eq i64 %14, 0
  br i1 %15, label %16, label %23

16:                                               ; preds = %12
  %17 = load i32*, i32** %2, align 8, !tbaa !2
  %18 = load i64, i64* %4, align 8, !tbaa !8
  %19 = getelementptr inbounds i32, i32* %17, i64 %18
  %20 = load i32, i32* %19, align 4, !tbaa !6
  %21 = load i32, i32* %3, align 4, !tbaa !6
  %22 = add nsw i32 %21, %20
  store i32 %22, i32* %3, align 4, !tbaa !6
  br label %30

23:                                               ; preds = %12
  %24 = load i32*, i32** %2, align 8, !tbaa !2
  %25 = load i64, i64* %4, align 8, !tbaa !8
  %26 = getelementptr inbounds i32, i32* %24, i64 %25
  %27 = load i32, i32* %26, align 4, !tbaa !6
  %28 = load i32, i32* %3, align 4, !tbaa !6
  %29 = sub nsw i32 %28, %27
  store i32 %29, i32* %3, align 4, !tbaa !6
  br label %30

30:                                               ; preds = %23, %16
  br label %31

31:                                               ; preds = %30
  %32 = load i64, i64* %4, align 8, !tbaa !8
  %33 = add i64 %32, 2
  store i64 %33, i64* %4, align 8, !tbaa !8
  br label %7, !llvm.loop !10

34:                                               ; preds = %10
  %35 = load i32, i32* %3, align 4, !tbaa !6
  %36 = bitcast i32* %3 to i8*
  call void @llvm.lifetime.end.p0i8(i64 4, i8* %36) #2
  ret i32 %35
}

; Function Attrs: argmemonly nofree nosync nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #1

; Function Attrs: argmemonly nofree nosync nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #1

attributes #0 = { nounwind uwtable "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nofree nosync nounwind willreturn }
attributes #2 = { nounwind }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"Ubuntu clang version 12.0.1-19ubuntu3"}
!2 = !{!3, !3, i64 0}
!3 = !{!"any pointer", !4, i64 0}
!4 = !{!"omnipotent char", !5, i64 0}
!5 = !{!"Simple C/C++ TBAA"}
!6 = !{!7, !7, i64 0}
!7 = !{!"int", !4, i64 0}
!8 = !{!9, !9, i64 0}
!9 = !{!"long", !4, i64 0}
!10 = distinct !{!10, !11}
!11 = !{!"llvm.loop.mustprogress"}
