Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47690 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751470AbeCNNBL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 14 Mar 2018 09:01:11 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w2ECwpel146575
        for <linux-integrity@vger.kernel.org>; Wed, 14 Mar 2018 09:01:11 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2gpyruufjy-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 14 Mar 2018 09:01:10 -0400
Received: from localhost
        by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Wed, 14 Mar 2018 13:01:08 -0000
Subject: Re: [PATCH v3 4/4] fuse: define the filesystem as untrusted
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Stef Bon <stefbon@gmail.com>
Cc: linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
        Seth Forshee <seth.forshee@canonical.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Dongsu Park <dongsu@kinvolk.io>,
        Alban Crequy <alban@kinvolk.io>,
        "Serge E. Hallyn" <serge@hallyn.com>
Date: Wed, 14 Mar 2018 09:01:01 -0400
In-Reply-To: <CANXojczCU3UC4xsPYzAYqFW3_WR9Z7QO_exd4dB6eyQR2STuUg@mail.gmail.com>
References: <1520540650-7451-1-git-send-email-zohar@linux.vnet.ibm.com>
         <1520540650-7451-5-git-send-email-zohar@linux.vnet.ibm.com>
         <CANXojczCU3UC4xsPYzAYqFW3_WR9Z7QO_exd4dB6eyQR2STuUg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1521032461.3547.404.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, 2018-03-14 at 08:52 +0100, Stef Bon wrote:
> I do not have any comments about the patches but a question.
> I completely agree that the files can change without the VFS knowing
> about it, but isn't that in general the case with filesystems with a
> backend shared with others (network fs's?).

Right, the problem is not limited to fuse, but needs to be addressed
before unprivileged fuse mounts are upstreamed.

Alban's response to this question:
https://marc.info/?l=linux-kernel&m=151784020321045&w=2

Mimi
