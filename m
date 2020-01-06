Return-Path: <SRS0=wcDA=23=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E26CC33C8C
	for <linux-integrity@archiver.kernel.org>; Mon,  6 Jan 2020 16:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B77C2081E
	for <linux-integrity@archiver.kernel.org>; Mon,  6 Jan 2020 16:12:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gYN8qm9g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgAFQKj (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 6 Jan 2020 11:10:39 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35735 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgAFQKj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Jan 2020 11:10:39 -0500
Received: by mail-wm1-f66.google.com with SMTP id p17so15848447wmb.0
        for <linux-integrity@vger.kernel.org>; Mon, 06 Jan 2020 08:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=lKFIQHaKUHD2UmFMf44CL03yjerDzDCte0G5za7Hzaw=;
        b=gYN8qm9gfI4NDVj7y1aSRpVDDuB6bfgMDg0dGrfKkOZz8EwVE2DIR3ZiHKZ/Vb2/81
         ocxy5ZzV7c/CbFC5W7RV0kU8jLCvya4o9+5hG83RRMHLv6LX+6j3xtvhwmUyHdLyvYzF
         Rr7XG6qC/KXrU7sht5+bHIyepl50iz8aoEQKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=lKFIQHaKUHD2UmFMf44CL03yjerDzDCte0G5za7Hzaw=;
        b=EfqvaB4JbSY4n2t8LIwASvT/0PrWprRhTkgWgk0/8vxjSG59Q16tAzAfsZVSndqJVW
         beaq+3EVUZ0JRIZ2z7HWX8XY/Sbvc+xtjoNMZxzPhsOTAva2wRhsPdd8XqPWQqfe3ZUr
         5wPo0mZXmBSiYulFig99ukEeB8uRPJqM66nfSgc2ZZyL+GisSzw1NpLqdMNuitcIMgMA
         ESIW8T7Nb6BWREAkcMPOfUAHbERneacLGjnyyW2OrLIUA1CzC3aaczgADEWjofgrOhIG
         H+BqlAyzX8GC/uq9q46RKQ4GXLgBz4DIBIAwqbEb3VukAYA6koJN0wA1hT8aVbVr1z5g
         hFlw==
X-Gm-Message-State: APjAAAUHyVyw4UtjBJvWRH8bZGhmNnC3KQm0le6skmdPnXH0KiHVDTNx
        1Ctm7TUI9MXgFrFUP2B4eWPGHg==
X-Google-Smtp-Source: APXvYqymGd76zlAEst94AWo4Z3ZR8S+gC9+ZcYLTd0XrXTbf2ufdGmSY2XlY51LnNMXAYaPwvBfTeA==
X-Received: by 2002:a7b:cbc8:: with SMTP id n8mr35083327wmi.35.1578327037092;
        Mon, 06 Jan 2020 08:10:37 -0800 (PST)
Received: from ?IPv6:2a00:79e0:42:204:51d1:d96e:f72e:c8c0? ([2a00:79e0:42:204:51d1:d96e:f72e:c8c0])
        by smtp.gmail.com with ESMTPSA id i5sm72940135wrv.34.2020.01.06.08.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 08:10:36 -0800 (PST)
Message-ID: <e362242edea8931f045beea1228de99b6572aa89.camel@chromium.org>
Subject: Re: [PATCH] ima: add the ability to query ima for the hash of a
 given file.
From:   Florent Revest <revest@chromium.org>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        linux-integrity@vger.kernel.org
Cc:     kpsingh@chromium.org, mjg59@google.com, zohar@linux.ibm.com,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Florent Revest <revest@google.com>
Date:   Mon, 06 Jan 2020 17:10:35 +0100
In-Reply-To: <8f4d9c4e-735d-8ba9-b84a-4f341030e0cf@linux.microsoft.com>
References: <20191220163136.25010-1-revest@chromium.org>
         <8f4d9c4e-735d-8ba9-b84a-4f341030e0cf@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2019-12-20 at 08:48 -0800, Lakshmi Ramasubramanian wrote:
> On 12/20/2019 8:31 AM, Florent Revest wrote:
> 
> >   
> > +/**
> > + * ima_file_hash - return the stored measurement if a file has
> > been hashed.
> > + * @file: pointer to the file
> > + * @buf: buffer in which to store the hash
> > + * @buf_size: length of the buffer
> > + *
> > + * On success, output the hash into buf and return the hash
> > algorithm (as
> > + * defined in the enum hash_algo).
> > + * If the hash is larger than buf, then only size bytes will be
> > copied. It
> > + * generally just makes sense to pass a buffer capable of holding
> > the largest
> > + * possible hash: IMA_MAX_DIGEST_SIZE
> 
> If the given buffer is smaller than the hash length, wouldn't it be 
> better to return the required size and a status indicating the buffer
> is not enough. The caller can then call back with the required
> buffer.
> 
> If the hash is truncated the caller may not know if the hash is
> partial or not.

I agree with Mimi's answer that the caller would know based on the
returned hash algorithm.

> > + *
> > + * If IMA is disabled or if no measurement is available, return
> > -EOPNOTSUPP.
> > + * If the parameters are incorrect, return -EINVAL.
> > + */
> > +int ima_file_hash(struct file *file, char *buf, size_t buf_size)
> > +{
> > +	struct inode *inode;
> > +	struct integrity_iint_cache *iint;
> > +	size_t copied_size;
> > +
> > +	if (!file || !buf)
> > +		return -EINVAL;
> > +
> > +	if (!ima_policy_flag)
> > +		return -EOPNOTSUPP;
> > +
> > +	inode = file_inode(file);
> > +	iint = integrity_iint_find(inode);
> > +	if (!iint)
> > +		return -EOPNOTSUPP;
> > +
> > +	mutex_lock(&iint->mutex);
> > +	copied_size = min_t(size_t, iint->ima_hash->length, buf_size);
> > +	memcpy(buf, iint->ima_hash->digest, copied_size);
> > +	mutex_unlock(&iint->mutex);
> > +
> > +	return iint->ima_hash->algo;
> 
> Should the hash algorithm be copied from iinit->ima_hash to a local 
> variable while holding the mutex and that one returned?
> 
> I assume iinit->mutex  is taken to ensure iinit->ima_hash is not
> removed while this function is accessing it.

Ah! Good catch, thank you :) 

