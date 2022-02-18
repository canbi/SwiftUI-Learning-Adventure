//
//  ActivityTypeCapsule.swift
//  HabitTrackingApp
//
//  Created by Can Bi on 6.02.2022.
//

import SwiftUI

struct ActivityTypeCapsule: View {
    let activity: Activity
    
    var body: some View {
        ZStack{
            //ACTIVITY TYPE NAME
            HStack(alignment: .top){
                Text("\(activity.activityType.name)")
                    .bold()
                    .font(.body)
                    .foregroundColor(.white)
                    .padding(EdgeInsets.init(top: 4, leading: 45, bottom: 4, trailing: 10))
                    .background(RoundedRectangle(cornerRadius: 15).fill(activity.activityType.color))
                Spacer()
                
                VStack(alignment: .trailing){
                    //ROUTINE TYPE
                    Text(activity.routine).capsuleTextStyle()
                    
                    //ACTIVITY GOAL
                    Text(activity.milestone.value).capsuleTextStyle(color: activity.milestone.color)
                }
            }
            //EMOJİ
            VStack(alignment: .leading){
                HStack(alignment: .top){
                    Text(activity.activityType.emoji)
                        .font(.system(size: 36))
                    Spacer()
                }
                Spacer()
            }
        }
    }
}
