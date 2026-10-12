Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0E53ACA71
	for <linux-integrity@vger.kernel.org>; Mon, 12 Oct 2026 14:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791814604; cv=none; b=pmV4w37SVC7n+4PDvpKDZ6NLQk1Pt2fR1ESPeeY1v5nCnaOcf8tsj+4Sx9VGMb3YQZP2ea6hRLDxT5b1lErH6yCwJoii2jE9I8ZemOhDLLn96+FQi7k50S/plJS0LKnP493eBwt8vxWR1I6POSxSPJQnQCxZnVQvjbqtLh7Z7mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791814604; c=relaxed/simple;
	bh=shmolJxvI3RFleQ+crYUcs8/qC3TjBJhcdJjT+VCboI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iUd2EGOji1FKoXMiL2F+FCYHcigQzbCFYP8fCC4mWnKPR9lC9KFZ0YocgzbzJZI87TmfQeK3bU15FyZcUoTAd7Bbo7JJSoIZKsHzmc3ATpdxrDUTBT74/p/WHPJfskINv4rUsOaKsKvSynpYh469Pb3O2hW4VNeIgYSDKjT3lsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DtHDBal2; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=oHKd88Xf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DtHDBal2";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="oHKd88Xf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791814602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ae0YyaBMRBi9QvMtuCD5/ZgDBRqhVmjNOSyXkR59Fsc=;
	b=DtHDBal2TcbY3x48zZQ2fODPURa6Snyw3VCVVF5mc+QLbmkew6d1r0dEdZpve0vD2Y3XNZ
	Q3ZTDz0dsj+FadMGvX5vtjb89t7wb/c8TiUGZPpbalu+KZY1lfGSWXPNmlKKgR4OWicFb9
	ZyTyB4a9IrF58+mVftpzvvtvBlW9Ass=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-Q-jjjdeNNT2p6-dNiuuOmw-1; Mon, 12 Oct 2026 14:16:34 +0000
X-MC-Unique: Q-jjjdeNNT2p6-dNiuuOmw-1
X-Mimecast-MFC-AGG-ID: Q-jjjdeNNT2p6-dNiuuOmw_1791814593
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48c50ed05abso1833803f8f.0
        for <linux-integrity@vger.kernel.org>; Mon, 12 Oct 2026 07:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791814593; x=1792419393; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ae0YyaBMRBi9QvMtuCD5/ZgDBRqhVmjNOSyXkR59Fsc=;
        b=oHKd88XfEsFMdU8xqoTQL3gKLdZ1RHWqf/TOGwdH4PB1lVb56Rta5eD4Ne0/yRxey+
         e3Wnkwt2ly7NZfMSBR7kFEi6EXAeiiAbzxijQBN58unWZTtReS/PUeilOtijAcnzDL8n
         jR2Cw6Vw4dh64wjAyZhYciJW73fDK+oSyxeBdffiTDa4kuZRenzd9cEQFsjFRlr683Bc
         r2FTTw7n+gQ9GB8sLyyoMglOFjM+tgMpAAxswXhP37GUY7mkexkPVGnT/sYTecqqb6VQ
         W5AIoxAqQJWT2iRiR3NaYScAZo+6XigllSV+E+ZKMdnYdWSxcL00kAsYSOJUliYE8Ieh
         wnAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791814593; x=1792419393;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ae0YyaBMRBi9QvMtuCD5/ZgDBRqhVmjNOSyXkR59Fsc=;
        b=rkGvAVo+Fni3eCYPnIM2QwkYW5YN3PcVRoL8nL4eIGE2CPDGXLJhUJDtHw9vP5QyR/
         sU1p1wAimI8S1wgGRNk2yUUMwP2TpdGv6WDTKobjcSURIbC8iQX9TTxoU6RDAJpTcrhE
         iFlGdbY+khrBIxH6TUrJCOL/uhkqgQUtZo9nExWj7YogwYMpeRdDFP6JMgBjgJGi6OgI
         H5DYbBDN2CgJ7JESktg6b54+S8/lss9lYnow84XXANAHMsQURzDt/C4/x8RKuXuwojXw
         Wi7e1WKMbMnnQlgTSPaBjuMPO8s8of3hjySJsMowruENuSaXcwRPiKu3StfZ95PQAZJm
         XF5A==
X-Gm-Message-State: AFq9FYJr2L5KZJXGmFjsPGZXCAkgUcirzcvOCcKH05kxqAFmpWIYr9vM
	4Dcl3qtK87MmMU7BiYUccNYTLFecrNR3G2V5xk1fDKRZReliVutdHE5kYdTvlm8DZZelOqXq2LU
	BJqM8ceQUKR7CUlgi36ahrLvLIQSC391C8NweGxa+2fpzq4bFkMtxUaJ4cKP8pk7Of/6bxU139o
	2SnA==
X-Gm-Gg: AYBFou0zZpuepn6XIlcUenOPiz5HPMIfE68MGRyPngCdVZf5K8TH2zYwVDiPKrV6u4M
	Lb9FYltb09EmYZ2wFfR0uYXb7qjMmtUFBwnxJ9jrfO9WxTj0IKf8YPUAJ8bLk5AfH3I44zLzgo/
	/yTmxgpF0MvW7PZNLs4zeAvsT+gsoqlcS0pF8JMFwE1V6PYGF6Qe5itmgYLDtZbSAZuSg4GBPfL
	7PXyn+PWocprUY6c8hcXPe40bsyr3SAMvVzeDCNT9FSi4CNKDZsSotVtfxvpI4Z+mUv6sSzRO7s
	sbtBwtHcH0UndmGBabKnnhzJw1kmj9TOI44N7AvMQRLCDqBCqH7dvOuhwBbe+1hzb9ZJsn5guDu
	WDJU=
X-Received: by 2002:a05:600c:620e:b0:4a1:7c56:d4e2 with SMTP id 5b1f17b1804b1-4a18e4b2aebmr194094735e9.16.1791814593116;
        Mon, 12 Oct 2026 07:16:33 -0700 (PDT)
X-Received: by 2002:a05:600c:620e:b0:4a1:7c56:d4e2 with SMTP id 5b1f17b1804b1-4a18e4b2aebmr194094035e9.16.1791814592552;
        Mon, 12 Oct 2026 07:16:32 -0700 (PDT)
Received: from sgarzare-redhat ([94.32.38.194])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18dcd7dd3sm186331845e9.2.2026.10.12.07.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 07:16:31 -0700 (PDT)
Date: Mon, 12 Oct 2026 16:16:26 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Stuart Yoder <stuart.yoder@arm.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Chu Guangqing <chuguangqing@inspur.com>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tpm_crb: Remove dead code from crb_map_res()
Message-ID: <aszqTFP9fTZg_gXa@sgarzare-redhat>
References: <20261010235500.2915629-1-jarkko@kernel.org>
 <asy0K_6VkuAn9rTB@sgarzare-redhat>
 <aszhPcubTH8HKxh2@kernel.org>
 <aszmcDeBBIJ5zvPw@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aszmcDeBBIJ5zvPw@kernel.org>

On Mon, Oct 12, 2026 at 04:53:52PM +0300, Jarkko Sakkinen wrote:
>On Mon, Oct 12, 2026 at 04:31:45PM +0300, Jarkko Sakkinen wrote:
>> On Mon, Oct 12, 2026 at 12:23:05PM +0200, Stefano Garzarella wrote:
>> > On Sun, Oct 11, 2026 at 02:54:57AM +0300, Jarkko Sakkinen wrote:
>> > > In all the pre-existing call sites both @iomem and @iobase_ptr are either
>> >
>> > Do you mean @iores ?
>> >
>> > > both NULL or have a valid address.
>> > >
>> > > Add an invariant for the expeced conditions and remove a dead basic block.
>> > > The second block is dead given that if @iomem turns out not to be NULL,
>> > > neither can't be @iobase_ptr.
>> > >
>> > > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
>> > > ---
>> > > v2:
>> > > - Updated the commit message in order to clarify things better.
>> > > - Updated the invariant in order to address checkpatch.pl --strict
>> > >   errors.
>> > >  drivers/char/tpm/tpm_crb.c | 9 +++------
>> > >  1 file changed, 3 insertions(+), 6 deletions(-)
>> > >
>> > > diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
>> > > index ceb4100ba400..833226966fa2 100644
>> > > --- a/drivers/char/tpm/tpm_crb.c
>> > > +++ b/drivers/char/tpm/tpm_crb.c
>> > > @@ -570,15 +570,12 @@ static void __iomem *crb_map_res(struct device *dev, struct resource *iores,
>> > >  	if (start != new_res.start)
>> > >  		return IOMEM_ERR_PTR(-EINVAL);
>> > >
>> > > +	if (!iores != !iobase_ptr)
>> > > +		return IOMEM_ERR_PTR(-EINVAL);
>> > > +
>> > >  	if (!iores)
>> > >  		return devm_ioremap_resource(dev, &new_res);
>> > >
>> > > -	if (!*iobase_ptr) {
>> >
>> > Sorry to insist, but in the commit description we talk about @iobase_ptr
>> > can't be null, and I agree, but here we were checking the value of the
>> > pointer, so IMO this code was not dead.
>> >
>> > But again, I know nothing on this code. So, if you think it's correct go
>> > head, I'm surely missing something.
>>
>> Ugh, you're actually right, and this is not, and should not have sent
>> this. And it is for lazy init.

Yeah, a lazy init makes sense.

>>
>> I need to sanity check my test environment because I thought I was
>> testing this with swtpm emulated tpm_crb but tests passed, and this
>> should not work.
>>
>> Sorry and thanks :-)

You're welcome!

>>
>> Just wanted to make it explicit that I was making somehting extremely
>> stupid.

Don't beat yourself up, it happens to all of us! Thanks for taking the 
time to check and clarify!

>
>Probably too much multitasking lately with all these bugs.
>
>Lessons learned is that from now on I keep my own contributions
>and reviewing in separate sessions. Things have gotten much
>busier than they used to be so need to adapt and learn how
>to have focus on all actitivies :-)

Yeah, it's something that's happening here too, and it's a real pain to 
deal with! :-(

Thanks,
Stefano

