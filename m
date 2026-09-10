Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DADA29E0E5
	for <linux-integrity@vger.kernel.org>; Thu, 10 Sep 2026 02:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789007272; cv=none; b=G5YZ6ioBpLSB5aD06oUj72LElHO2BHfPDeAGJlOf4DrRn6o7M5J0cyNqy/Y7p+LS7HnpXFqCyQtSA9tCgNtYqMSCsf4pj6+vK27MjSq7RyZTp7e8KYJBGV8hSBhGNUoQYtZTHpmUyVxX4kPNfMRuJGZgZvXMHMMdmnn3NfJ7HJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789007272; c=relaxed/simple;
	bh=epHSXBuQ2AIm4Hu/Zr1y7hIy117Ko3f+MG5YEzbXX7g=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RaRkA4TbnEDb+5wHL/oAubHAsJ8cabrU4z7TWX2CdAad7jdrdbw3GqVLYnmUbQULu5Rh2J9oWr8hLvkAbHsteOFRplsgVrqIkOGrtn2eRJfAEGYPAk8vtMmCQ7eD1NzTQpOTq/eGOwkyhHeGLXcasz+SPOrJxB0zuM7Gl7L9rtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Tmh50WBA; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Tmh50WBA"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c25b661d37dso961393566b.0
        for <linux-integrity@vger.kernel.org>; Wed, 09 Sep 2026 19:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1789007269; x=1789612069; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=tjOhy7ms73Ne+PBWfcDOjVBGfsqw9byyhSgof+mlxb0=;
        b=Tmh50WBABi1rd+7fg+XuLh2NU0zNOKYIkP9jAXDOx9gP9akRHbv5W2qSIB+acQeNOe
         Lmk4TG51UFx+BvqKm0qXZ9P0iE2wRFuCLnFyIujCjV+Z8AWGoooO+PnvwLvji8mor1zW
         3l5mczJMJTPND+7icZefjVBfhfm5OHd7oMbvHUNzEHax38cDhbFFaDVp91Y182VFY2an
         dyDNvuKbd2tTQMVn5HuEtpMY0J5fqdjPbpbqsDoLTsBBGxC971gKWErUFNXnpaTURH+H
         1WgvutuT4JQxp4PiRSRqE3B6fd7wZqDwDF7publfonza0qu0d4Di5UR0Hmm3Hh5SgP8a
         lLjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789007269; x=1789612069;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tjOhy7ms73Ne+PBWfcDOjVBGfsqw9byyhSgof+mlxb0=;
        b=YHiGU19QjQLNLOWmZwnAN9GjxrXjX9oJnlOiTMfGhfLOJnUg2NcMrf1bmo34JaFXs0
         ItzzZTIF7gyLMEHyFSlGcSEW8Wor3M/gAn6RuSXSqjDiQUfJe644Z/uLdOJLLelyBovk
         GVhT9/W43FX72yfe96vo5lILCLvCucpTG/fR9FFbfodDHUCbRtbXIhcuiQkyuivUgo4e
         tCNgQawtiwvif27sYkIubeVI4J+3HjAX/mI1FBWft1Mj4qQ+o5G0RqyXDsGnNImiOZlJ
         caiv2o//0ILpgTcKfHTddw76eSC1oK2ybGsIz/ASn/H4h+g2dQ4NnvWFGBQUPPTCQnqc
         iC7A==
X-Forwarded-Encrypted: i=1; AKwUvByQn5ZTmBBBzrQkvsnDhcjkd0eIjPBrwcpCVybQfrQPtV/Z6fLf6J2JeNgLsNocZ5ssT9uv4hOGkRrsShHdASE=@vger.kernel.org
X-Gm-Message-State: AFuF++mwQ4m6jd1W2g/nKgO/VvW1Pxvhy2jCovfbQ/6ERhn8wlvfNdoL
	k7wVkKlbNd/ynFSys3DP8jhFS5pLfycROBMm3Fe0mt2kFHVxS/izfMKEDmuklfwvmhs=
X-Gm-Gg: AYBFou1I3hCgT6gQ4aT27iDdSYwySlaxfExDxceW+2WwesddSc3Yrbkvv78Jeq/BZtA
	RP0d+aR3NAUz1kC4rvKggVu85+GtVCihsmKtVy3lKScvyxfGDcRPZoVgGsrfO/6dlGaDAcKbv5R
	UIio1v1TqPgnIuxo2XnAAQdjh5aOOfBgQjUXwEot6i62xBirDRh+useoMc2qWgdjlLqk9D2J0CT
	+7ablYXm3wGWSrxeX4vVK724VmVRSMjNKJP2KCYamD9TC0myWKie1YNsRSGYteLI+TJqUNpHOmp
	8ag43lE2NXvx0v7pjs7t0PDooOXPviWtl8TAE57f3cQ2VSi+/UjPeD3yTn074AIdYWz8YIPn4ol
	RNcanM5s32R1gysHxg3eRke61SXeQxkjIbN2mRpH3zNvbQNuCKgO0MqLgwsdJhsjO9Ma3ci/iFd
	D3uBM8dln8hGm7+cgu5m6o8P67UzP9GQSG8SuCJjBTkSZ/f3sJCzSVDCAZtEqiYirTD9Wm+Nji1
	DdIOH5DHDvCOJzLp4807Q==
X-Received: by 2002:a17:907:7b82:b0:c21:9b4b:2690 with SMTP id a640c23a62f3a-c260c9e75e9mr1456183466b.17.1789007268656;
        Wed, 09 Sep 2026 19:27:48 -0700 (PDT)
Received: from r1chard ([2401:e180:8d23:5f05:2c5b:a1bb:33f1:a712])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d7e83d9cdsm1275985a91.11.2026.09.09.19.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 19:27:47 -0700 (PDT)
From: Richard Lyu <richard.lyu@suse.com>
X-Google-Original-From: Richard Lyu <r1chard@r1chard>
Date: Thu, 10 Sep 2026 10:27:43 +0800
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Richard Lyu <richard.lyu@suse.com>, peterhuewe@gmx.de, jgg@ziepe.ca,
	fourier.thomas@gmail.com, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: Remove ineffective wmb() from tpm_pm_resume()
Message-ID: <aqIVn0cDBvIYKggE@r1chard>
References: <20260908095748.78967-1-richard.lyu@suse.com>
 <aqHjDClIsaboPBSh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aqHjDClIsaboPBSh@kernel.org>
User-Agent: Mutt/2.2.16 (2025-11-22)

On 2026/09/10 01:51, Jarkko Sakkinen wrote:
>On Tue, Sep 08, 2026 at 05:58:02PM +0800, Richard Lyu wrote:
>> The comment above the wmb() in tpm_pm_resume() states that the barrier
>> guarantees TPM_CHIP_FLAG_SUSPENDED is written last, so that hwrng does
>> not activate before the chip has been fully resumed.  It cannot do so:
>> it is placed after the store that clears the flag, and therefore does
>> not order the preceding resume work before that store.  It also has
>> nothing to pair with, as tpm_try_get_ops() contains no matching read
>> barrier.
>>
>> Drop the barrier along with the comment rather than leave a no-op
>> behind.  Should such ordering turn out to be needed, it would require
>> paired barriers or locking.
>>
>> Fixes: 99d464506255 ("tpm: Prevent hwrng from activating during resume")
>> Link: https://lore.kernel.org/all/a62fc816-259a-4d28-a265-e425bc17ed50@gmail.com/
>> Signed-off-by: Richard Lyu <richard.lyu@suse.com>
>
>I agree that wmb() is necessary but what is the bug here?
>
>Agree with the change but I'm not convinced about fixes tag here.

You're right. There is no actual bug being fixed here, so a Fixes tag is not
needed. This patch only removes redundant code. I will send a v2 without the
tag.

Best Regards,
Richard Lyu
