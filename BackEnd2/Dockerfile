#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["BackEnd2/BackEnd2.csproj", "BackEnd2/"]
RUN dotnet restore "BackEnd2/BackEnd2.csproj"
COPY . .
WORKDIR "/src/BackEnd2"
RUN dotnet build "BackEnd2.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "BackEnd2.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "BackEnd2.dll"]