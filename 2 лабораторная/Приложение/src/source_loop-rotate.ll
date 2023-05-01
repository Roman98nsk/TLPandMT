; ModuleID = 'source.ll'
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
  %7 = load i64, i64* %4, align 8, !tbaa !8
  %8 = icmp ult i64 %7, 1024
  br i1 %8, label %.lr.ph, label %9

.lr.ph:                                           ; preds = %1
  br label %11

._crit_edge:                                      ; preds = %30
  br label %9

9:                                                ; preds = %._crit_edge, %1
  %10 = bitcast i64* %4 to i8*
  call void @llvm.lifetime.end.p0i8(i64 8, i8* %10) #2
  br label %35

11:                                               ; preds = %.lr.ph, %30
  %12 = load i64, i64* %4, align 8, !tbaa !8
  %13 = urem i64 %12, 2
  %14 = icmp eq i64 %13, 0
  br i1 %14, label %15, label %22

15:                                               ; preds = %11
  %16 = load i32*, i32** %2, align 8, !tbaa !2
  %17 = load i64, i64* %4, align 8, !tbaa !8
  %18 = getelementptr inbounds i32, i32* %16, i64 %17
  %19 = load i32, i32* %18, align 4, !tbaa !6
  %20 = load i32, i32* %3, align 4, !tbaa !6
  %21 = add nsw i32 %20, %19
  store i32 %21, i32* %3, align 4, !tbaa !6
  br label %29

22:                                               ; preds = %11
  %23 = load i32*, i32** %2, align 8, !tbaa !2
  %24 = load i64, i64* %4, align 8, !tbaa !8
  %25 = getelementptr inbounds i32, i32* %23, i64 %24
  %26 = load i32, i32* %25, align 4, !tbaa !6
  %27 = load i32, i32* %3, align 4, !tbaa !6
  %28 = sub nsw i32 %27, %26
  store i32 %28, i32* %3, align 4, !tbaa !6
  br label %29

29:                                               ; preds = %22, %15
  br label %30

30:                                               ; preds = %29
  %31 = load i64, i64* %4, align 8, !tbaa !8
  %32 = add i64 %31, 2
  store i64 %32, i64* %4, align 8, !tbaa !8
  %33 = load i64, i64* %4, align 8, !tbaa !8
  %34 = icmp ult i64 %33, 1024
  br i1 %34, label %11, label %._crit_edge, !llvm.loop !10

35:                                               ; preds = %9
  %36 = load i32, i32* %3, align 4, !tbaa !6
  %37 = bitcast i32* %3 to i8*
  call void @llvm.lifetime.end.p0i8(i64 4, i8* %37) #2
  ret i32 %36
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
