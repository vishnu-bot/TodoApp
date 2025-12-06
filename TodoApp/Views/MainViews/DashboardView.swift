//
//  DashboardView.swift
//  TodoApp
//
//  Created by Vishnu on 06/12/25.
//

import SwiftUI
import Charts

struct DashboardView: View {
    @EnvironmentObject var viewModel: CoreDataViewModel
    
    var completedCount: Int {
        viewModel.savedEntities.filter { $0.isCompleted }.count
    }
    
    var pendingCount: Int {
        viewModel.savedEntities.filter { !$0.isCompleted }.count
    }
    
    var totalCount: Int {
        viewModel.savedEntities.count
    }
    
    var completionRate: Double {
        guard totalCount > 0 else { return 0 }
        return Double(completedCount) / Double(totalCount)
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // Summary Cards
                    HStack(spacing: 15) {
                        SummaryCard(title: "Total", count: totalCount, color: .red)
                        SummaryCard(title: "Completed", count: completedCount, color: .red)
                        SummaryCard(title: "Pending", count: pendingCount, color: .red)
                    }
                    .padding(.horizontal)
                    
                    // Progress Section
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Completion Rate")
                            .font(.headline)
                        
                        ProgressView(value: completionRate)
                            .tint(.red)
                            .scaleEffect(x: 1, y: 2, anchor: .center)
                        
                        Text("\(Int(completionRate * 100))%")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(12)
                    .padding(.horizontal)
                    
                    // Category Breakdown (Placeholder for now as we just added categories)
                    if #available(iOS 16.0, *) {
                        VStack(alignment: .leading) {
                            Text("Tasks by Status")
                                .font(.headline)
                                .padding(.bottom, 5)
                            
                            Chart {
                                BarMark(
                                    x: .value("Status", "Completed"),
                                    y: .value("Count", completedCount)
                                )
                                .foregroundStyle(.red)
                                
                                BarMark(
                                    x: .value("Status", "Pending"),
                                    y: .value("Count", pendingCount)
                                )
                                .foregroundStyle(.red)
                            }
                            .frame(height: 200)
                        }
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(12)
                        .padding(.horizontal)
                    }
                    
                    Spacer()
                }
                .padding(.top)
            }
            .navigationTitle("Dashboard")
        }
    }
}

struct SummaryCard: View {
    let title: String
    let count: Int
    let color: Color
    
    var body: some View {
        VStack {
            Text("\(count)")
                .font(.largeTitle)
                .bold()
                .foregroundColor(color)
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(10)
    }
}

#Preview {
    DashboardView()
        .environmentObject(CoreDataViewModel.preview)
}
